module HelperMethods
  def click(*args)
    click_link_or_button(*args)
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance
