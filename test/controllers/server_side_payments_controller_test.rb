require 'test_helper'

class ServerSidePaymentsControllerTest < ActionDispatch::IntegrationTest
  test "should get create_payment" do
    get server_side_payments_create_payment_url
    assert_response :success
  end

  test "should get execute_payment" do
    get server_side_payments_execute_payment_url
    assert_response :success
  end

end
