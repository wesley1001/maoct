require 'test_helper'

class PayControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get wx_notify" do
    get :wx_notify
    assert_response :success
  end

end
