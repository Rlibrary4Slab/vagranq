require 'test_helper'

class NotificationsControllerTest < ActionController::TestCase
  test "should get flag_off" do
    get :flag_off
    assert_response :success
  end

  test "should get paginate" do
    get :paginate
    assert_response :success
  end

end
