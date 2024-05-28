require "test_helper"

class PortfoliosControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get portfolios_url
    assert_response :redirect
  end
end
