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

      within('.list') do
        within('.header') do
          page.should have_content('cartodb_id')
          page.should have_content('name')
          page.should have_content('description')
          page.should have_content('latitude')
          page.should have_content('longitude')
        end

        page.should have_css('tr.item', :count => 10)
        page.should have_css('tr.item td.cartodb_id', :text => '1')
        page.should have_css('tr.item td.name', :text => 'Feature 0')
        page.should have_css('tr.item td.description', :text => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
        page.should have_css('tr.item td.latitude', :text => '-16.506')
        page.should have_css('tr.item td.longitude', :text => '-151.7531')
      end

      page.should have_link('Create new feature')
      page.should have_link('or edit them in CartoDB')
      page.should have_css('.pagination', :text => '1 2 3')
    end
  end
end
