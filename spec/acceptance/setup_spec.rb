# coding: UTF-8

require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'cartoset setup', %q{
  In order to create an awesome geo-powered app
  as an astonishing developer
  I want to setup my cartoset app
} do

  scenario 'initial setup', :js => true do
    visit homepage

    current_path.should be == '/setup'

    page.should have_content 'Congratulations!'
    page.should have_content "CartosSet has been succesfully installed. It's time to adapt it to your needs."

    click 'Start configuration'

    current_path.should be == '/setup/steps/1'
    page.should have_content 'Connect your app with CartoDB'
    page.should have_content 'CartoSet stores its data in CartoDB, a powerful cloud-based database for geolocated data.'

    click 'Connect with CartoDB'

    current_path.should be == "/login"

    fill_in 'e-mail', :with => 'admin@example.com'
    fill_in 'password', :with => 'example'

    click 'Log in'

    current_path.should be == "/setup/steps/2"
    page.should have_content 'Name your app'
    page.should have_content "Don't be afraid. You will be able to change it later."
    fill_in "'Pandas in the world', 'Elvis sightings'...", :with => 'whs'

    click 'Save and continue'

    current_path.should be == "/setup/steps/3"

    page.should have_content 'Import your data'
    page.should have_content "Select which CartoDB table you want to use for this CartoSet. If you don't have tables created you will be able to create a new one."

    click 'Select table'
    click 'madrid_bars'

    page.should have_css('table.data tr th', :text => 'cartodb_id')
    page.should have_css('table.data tr th', :text => 'name')
    page.should have_css('table.data tr th', :text => 'address')

    page.should have_content 'Hawai'
    page.should have_content 'El Estocolmo'
    page.should have_content 'El Rey del Tallarín'

    click 'Use this table'

    current_path.should be == "/setup/steps/4"

    page.should have_content 'Done!'
    page.should have_content 'It looks like you have your CartoSet running in your server. Now...'

    page.should have_content 'Manage your data'
    page.should have_content 'Change and clean your data, geolocalize your features...'
    page.should have_link 'CartoDB table'

    page.should have_content 'Manage your site'
    page.should have_content 'Add images and videos, create additional pages...'
    page.should have_link 'CartoSet backoffice'

    page.should have_content 'Go to your site'
    page.should have_content 'Check how your users will see your site...'
    page.should have_link 'Public site'

  end
end