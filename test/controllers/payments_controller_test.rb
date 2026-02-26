require "test_helper"

class PaymentsControllerTest < ActionDispatch::IntegrationTest
  test "should get check" do
    get payments_check_url
    assert_response :success
  end

  test "should get result" do
    get payments_result_url
    assert_response :success
  end
end
