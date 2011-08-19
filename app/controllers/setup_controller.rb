class SetupController < ApplicationController
  include FeatureGetterHelper

  layout 'setup'

  before_filter :redirect_to_root_if_invalid_env
  skip_before_filter :show_setup_wizard_if_uninstalled

  def step
    step_id = params[:step_id] || 0

    case step_id
    when "1"
      @settings = OpenStruct.new Cartoset::Config.settings
    when "2"
      @settings = OpenStruct.new Cartoset::Config.settings
    when "3"
      Cartoset::Config.update params[:settings]

      result = CartoDB::Connection.tables || []
      @tables = result.tables
    when "4"
      @table = CartoDB::Connection.table params[:features_table]
      Cartoset::Config.update :features_table => @table.name
    end

    render "step#{step_id}"
  end

  def cartodb
      Cartoset::Config.update params[:settings]

      Cartoset::Config.setup_cartodb

      session[:return_to] = setup_path(:step_id => 2)

      redirect_to cartodb_authorize_path and return
  end

  def features_table_data
    table_name = params[:table_name]
    if table_name
      @table  = CartoDB::Connection.table table_name
      records = CartoDB::Connection.records table_name, {}
      @rows = records.rows if records
    end
    render :layout => false
  end

  def create_features_table
    table = {}

    if params[:qqfile] && request.body.present?
      table = FeaturesDataImporter.start request.body
    end

    render :json => table.to_json
  end

  def redirect_to_root_if_invalid_env
    redirect_to root_path and return unless Rails.env.development? || Rails.env.test?
  end
  private :redirect_to_root_if_invalid_env
end
