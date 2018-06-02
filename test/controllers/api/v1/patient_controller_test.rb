require 'test_helper'

class PatientsControllerTest < ActionDispatch::IntegrationTest

	test 'register new patient' do
		post '/consult/api/v1/patient', params: { name: 'Kelly', mobile: '9999999990' }
		json_response = JSON.parse(response.body)

		assert_response :created
		assert_equal 'success', json_response['status']
	end

	test 'register old patient' do
		@patient = patients(:patient1)
		
		post '/consult/api/v1/patient', params: { name: @patient.name, mobile: @patient.mobile }
		json_response = JSON.parse(response.body)

		assert_response :created
		assert_equal 'success', json_response['status']
	end

end
