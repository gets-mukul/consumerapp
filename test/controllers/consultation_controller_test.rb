require 'test_helper'

class ConsultationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get consultation_index_url
    assert_response :success
  end

end
