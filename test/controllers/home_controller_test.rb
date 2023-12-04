require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url
    assert_response :success
  end
  test 'should diplay welcome message' do
    get root_url
    assert_select 'h1', 'Welcome to Google Scraper!'
  end
  test 'should display two links' do
    get root_url
    assert_select 'a', 3
  end
end
