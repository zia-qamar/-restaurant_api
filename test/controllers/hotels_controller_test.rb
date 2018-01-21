require 'test_helper'

class HotelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hotel = hotels(:one)
  end

  test "should get index" do
    get api_v1_hotels_url, as: :json
    assert_response :success
  end

  test "should validate fields" do
    assert_no_difference('Hotel.count') do
      post api_v1_hotels_url, params: { hotel: { email: '', end_time: @hotel.end_time, start_time: @hotel.start_time, name: '', phone: '12345678' } }, as: :json
    end
    assert_response 422
    json_response = JSON.parse(@response.body)
    assert_equal json_response["name"], ["can't be blank"]
    assert_equal json_response["email"],  ["can't be blank", "is invalid"]
  end

  test 'start time should be less than end time' do
    assert_no_difference('Hotel.count') do
      post api_v1_hotels_url, params: { hotel: { email: 'sdfsdf@yahoo.com', end_time: Time.now.strftime("%H:%M:%S"), start_time: (Time.now + 1.minute).strftime("%H:%M:%S"), name: 'm aaa', phone: '878767' } }, as: :json
    end
    assert_response 422
    json_response = JSON.parse(@response.body)
    assert_equal json_response["end_time"], ["must be after the start time"]
  end

  test "should create hotel" do
    assert_difference('Hotel.count') do
      post api_v1_hotels_url, params: { hotel: { email: @hotel.email, end_time: @hotel.end_time, start_time: @hotel.start_time, name: @hotel.name, phone: @hotel.phone } }, as: :json
    end

    assert_response 201
  end

  test "should show hotel" do
    get api_v1_hotel_url(@hotel), as: :json
    assert_response :success
  end
end
