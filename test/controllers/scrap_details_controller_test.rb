require 'test_helper'

class ScrapDetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @scrap_detail = scrap_details(:one)
    @scrap = scraps(:one)
  end

  test "should be redirected if not logged in" do
    get scrap_details_url
    assert_response :redirect
  end

  test "should get index" do
    sign_in users(:one)
    get scraps_url
    assert_response :success
  end


end
