require 'test_helper'

class WellcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get wellcome_index_url
    assert_response :success
  end

  test "should get test" do
    get wellcome_test_url
    assert_response :success
  end

end
