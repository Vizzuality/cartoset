module NavigationHelpers

  def homepage
    "/"
  end

  def admin_dashboard
    "/admin"
  end

end

RSpec.configuration.include NavigationHelpers, :type => :acceptance
