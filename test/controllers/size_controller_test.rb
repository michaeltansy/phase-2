require 'test_helper'

class SizeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get size_index_url
    assert_response :success
  end

end
