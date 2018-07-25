require 'test_helper'

class CouponControllerTest < ActionDispatch::IntegrationTest

  
  test 'valid coupon application' do
    test_coupon = coupons(:SOCIAL100)
    get "/consult/api/v1/coupon/#{test_coupon.coupon_code}"
    json_response = JSON.parse(response.body)

    assert_response :ok
    assert_equal 'success', json_response['status']
    assert_equal (350-test_coupon.discount_amount), json_response['discount_price']
    assert_equal test_coupon.coupon_code, json_response['coupon']
  end


  test '150 redirect coupon application' do
    test_coupon = coupons(:SOCIAL150)
    get "/consult/api/v1/coupon/#{test_coupon.coupon_code}"
    json_response = JSON.parse(response.body)

    assert_response :ok
    assert_equal 'success', json_response['status']
    assert_equal (350-100), json_response['discount_price']
    assert_equal (test_coupon.coupon_code.sub '150', '100'), json_response['coupon']
  end


  test 'Expired coupon application' do
    get '/consult/api/v1/coupon/EXPIRED100'
    json_response = JSON.parse(response.body)

    assert_response :not_found
    assert_equal 'coupon expired', json_response['status']
  end


  test 'Used up coupon application' do
    get '/consult/api/v1/coupon/USED100'
    json_response = JSON.parse(response.body)

    assert_response :not_found
    assert_equal 'coupon expired', json_response['status']
  end


  test 'Non existent coupon application' do
    get '/consult/api/v1/coupon/NOTFOUND100'
    json_response = JSON.parse(response.body)

    assert_response :not_found
    assert_equal 'coupon not found', json_response['status']
  end


end
