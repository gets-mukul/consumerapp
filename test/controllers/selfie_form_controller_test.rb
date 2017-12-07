require 'test_helper'

class SelfieFormControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get selfie_form_show_url
    assert_response :success
  end

  test "should get create" do
    get selfie_form_create_url
    assert_response :success
  end

end
