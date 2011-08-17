class SetupController < ApplicationController
  include FeatureGetterHelper

  layout 'setup'

  before_filter :redirect_to_root_if_invalid_env
  skip_before_filter :show_setup_wizard_if_uninstalled

  def step
    step_id = params[:step_id] || 0

    case step_id
    when "1"
    when "2"
      Cartoset::Config.update :cartodb_host         => params[:oauth_host],
                              :cartodb_oauth_key    => params[:oauth_key],
                              :cartodb_oauth_secret => params[:oauth_secret]

      Cartoset::Config.setup_cartodb
    when "3"
      Cartoset::Config.update :app_name => params[:app_name]

      result = CartoDB::Connection.tables || []
      @tables = result.tables
    when "4"
      @table = CartoDB::Connection.table params[:features_table]
      Cartoset::Config.update :features_table => @table.name
    end

    render "step#{step_id}"
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
