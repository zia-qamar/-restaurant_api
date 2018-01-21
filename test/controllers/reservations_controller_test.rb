require 'test_helper'

class ReservationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reservation = reservations(:one)
  end

  test "should get index" do
    get api_v1_reservations_url, as: :json
    assert_response :success
    json_response = JSON.parse(@response.body)
    assert_equal json_response.length, 2
  end

  test "should validate uniqueness of reservation reservation" do
    assert_no_difference('Reservation.count') do
      post api_v1_reservations_url, params: { reservation:
                                                  { guest_id: @reservation.guest_id, hotel_id: @reservation.hotel_id, res_time: @reservation.res_time,
                                                    table_id: @reservation.table_id, guest_count: @reservation.guest_count } }, as: :json
    end
    assert_response 422
    json_response = JSON.parse(@response.body)
    assert_equal json_response["res_time"], ["has already been taken"]
  end

  test 'should create reservation' do
    assert_difference('Reservation.count') do
      post api_v1_reservations_url, params: { reservation:
                                                  { guest_id: @reservation.guest_id, hotel_id: @reservation.hotel_id, res_time: '2018-01-20 09:32:38',
                                                    table_id: @reservation.table_id, guest_count: @reservation.guest_count } }, as: :json
    end
    assert_response 201
  end

  test 'guest or hotel does not exist' do
    assert_no_difference('Reservation.count') do
      post api_v1_reservations_url, params: { reservation: { guest_id: 90, hotel_id: @reservation.hotel_id, res_time: @reservation.res_time } }, as: :json
    end
    assert_response 422

    assert_no_difference('Reservation.count') do
      post api_v1_reservations_url, params: { reservation: { guest_id: @reservation.guest_id, hotel_id: 999, res_time: @reservation.res_time } }, as: :json
    end
    assert_response 422
  end

  test 'should validate reservation time between hotel shift time' do
    assert_no_difference('Reservation.count') do
      post api_v1_reservations_url, params: { reservation: { guest_id: @reservation.guest_id, hotel_id: @reservation.hotel_id, res_time: Time.now.end_of_day } }, as: :json
    end
    assert_response 422
  end

  test "should show reservation" do
    get api_v1_reservation_url(@reservation), as: :json
    assert_response :success
  end

  test "should update reservation" do
    patch api_v1_reservation_url(@reservation), params: { reservation:
                                                { guest_id: @reservation.guest_id, hotel_id: 1, res_time: '2018-01-20 10:00:38',
                                                  table_id: 2, guest_count: 5 } }, as: :json
    assert_response 200
  end

  test "should destroy reservation" do
    assert_difference('Reservation.count', -1) do
      delete api_v1_reservation_url(@reservation), as: :json
    end

    assert_response 204
  end
end
