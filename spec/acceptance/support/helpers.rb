module HelperMethods
  def click(*args)
    click_link_or_button(*args)
  end

  def peich
    save_and_open_page
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance
