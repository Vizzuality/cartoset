class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :show_setup_wizard_if_uninstalled

  def features_table_name
    Cartoset::Config['features_table'] || ''
  end

  def show_setup_wizard_if_uninstalled
    redirect_to setup_path unless application_installed? && environment_valid?
  end
  private :show_setup_wizard_if_uninstalled

  def application_installed?
    Cartoset::Config.valid?
  end
  private :application_installed?

  def environment_valid?
    Rails.env.development? || Rails.env.test?
  end
  private :environment_valid?
end
