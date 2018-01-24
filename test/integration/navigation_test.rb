require 'test_helper'

class NavigationTest < ActionDispatch::IntegrationTest
  setup do
    @routes = Buttafly::Engine.routes
  end

  def test_spreadsheets
    # assert_generates '/', :controller => "buttafly/spreadsheets",
                                        # :action     => "index"
  end
end
