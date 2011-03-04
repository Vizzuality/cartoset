require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require "steak"
<<<<<<< HEAD
require "capybara/rails"
require "capybara/dsl"
require "selenium-webdriver"
=======
>>>>>>> Adds first admin controllers, views and specs

# Put your acceptance spec helpers inside /spec/acceptance/support
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

<<<<<<< HEAD
Capybara.default_driver    = :selenium
Capybara.default_wait_time = 10
Capybara.server_port = 3333

RSpec.configure do |config|

  config.include Warden::Test::Helpers
  config.include Capybara, :type => :acceptance

  config.before(:each) do
    Rails.cache.clear
  end

  config.after(:each) do
    case page.driver.class
    when Capybara::Driver::RackTest
      page.driver.rack_mock_session.clear_cookies
    when Capybara::Driver::Culerity
      page.driver.browser.clear_cookies
    when Capybara::Driver::Selenium
      page.driver.cleanup!
    end
    Capybara.use_default_driver
  end

end
=======
module Capybara
  alias peich save_and_open_page
end
>>>>>>> Adds first admin controllers, views and specs
