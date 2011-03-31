class SetupController < ApplicationController
  include FeatureGetterHelper

  layout 'setup'

  skip_before_filter :show_setup_wizard_if_uninstalled

  def step
    step_id = params[:step_id] || 0

    case step_id
    when "1"
      session[:return_to] = setup_path(:step_id => 2)
    when "2"
      Cartoset::Config.update :cartodb_oauth_key    => params[:oauth_key],
                              :cartodb_oauth_secret => params[:oauth_secret]

      Cartoset::Config.setup_cartodb
    when "3"
      Cartoset::Config.update :app_name => params[:app_name]

      @tables = CartoDB::Connection.tables || []
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
end
