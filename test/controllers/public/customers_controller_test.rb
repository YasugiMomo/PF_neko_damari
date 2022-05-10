require "test_helper"

class Public::CustomersControllerTest < ActionDispatch::IntegrationTest
  test "should get sho" do
    get public_customers_sho_url
    assert_response :success
  end

  test "should get edit" do
    get public_customers_edit_url
    assert_response :success
  end

  test "should get out" do
    get public_customers_out_url
    assert_response :success
  end
end
