module NavigationHelpers
  # Put helper methods related to the paths in your application here.

  def homepage
    "/"
  end
<<<<<<< HEAD
=======

  def admin_dashboard
    "/admin"
  end
>>>>>>> Adds first admin controllers, views and specs
end

RSpec.configuration.include NavigationHelpers, :type => :acceptance
