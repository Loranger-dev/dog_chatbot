require "test_helper"

class DogsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get dogs_new_url
    assert_response :success
  end

  test "should get index" do
    get dogs_index_url
    assert_response :success
  end

  test "should get show" do
    get dogs_show_url
    assert_response :success
  end
end
