require "test_helper"

class JobsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get jobs_index_url
    assert_response :success
  end

  test "should get refresh" do
    get jobs_refresh_url
    assert_response :success
  end
end
