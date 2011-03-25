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
  end
end