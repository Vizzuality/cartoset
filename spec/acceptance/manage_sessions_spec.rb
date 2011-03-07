require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Manage Sessions", %q{
  In order to access to the wonderful features of Cartoset
  As a user
  I want to identify myself in the application
} do

  scenario "Get authenticated" do
    login_as({'uid' => 1, 'username' => 'admin', 'email' => 'admin@example.com'})

    visit homepage

    page.should have_content("Hi admin!")
  end
end
