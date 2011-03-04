require File.expand_path(File.dirname(__FILE__) + '/../acceptance_helper')

feature "Dashboard" do

  scenario "main view" do
    create_random_features

    visit admin_dashboard

    within('#features_list') do
      page.should have_content('Your features')
      page.should have_css('input#search')
      page.should have_link('prev_page')
      page.should have_link('next_page')

      # within('.list_header') do
      #   page.should have_content('ID.')
      #   page.should have_content('NAME')
      #   page.should have_content('DESCRIPTION.')
      #   page.should have_content('LATITUDE')
      #   page.should have_content('LONGITUDE')
      # end
      #
      # page.should have_css('.list_items tr', :count => 10)
      # within('.list_items tr:first-child') do
      #   page.should have_css('td.cartodb_id', :text => '1')
      #   page.should have_css('td.name', :text => 'Feature 0')
      #   page.should have_css('td.description', :text => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
      #   page.should have_css('td.latitude', :text => '-16.5060')
      #   page.should have_css('td.longitude', :text => '-151.7531')
      # end
    end
  end
end
