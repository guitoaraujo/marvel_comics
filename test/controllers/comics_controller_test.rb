require "test_helper"

class ComicsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get comics_index_url
    assert_response :success
  end

  test "should get search" do
    get comics_search_url
    assert_response :success
  end
end
