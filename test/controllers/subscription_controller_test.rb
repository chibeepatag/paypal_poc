require 'test_helper'

class SubscriptionControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get subscription_show_url
    assert_response :success
  end

  test "should get create_payment" do
    get subscription_create_payment_url
    assert_response :success
  end

  test "should get execute_payment" do
    get subscription_execute_payment_url
    assert_response :success
  end

end
