require 'test_helper'

class GuestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @guest = guests(:one)
  end

  test "should get index" do
    get api_v1_guests_url, as: :json
    assert_response :success
  end

  test "should create guest" do
    assert_difference('Guest.count') do
      post api_v1_guests_url, params: { guest: { email: @guest.email, name: @guest.name } }, as: :json
    end
    assert_response :success
  end

  test 'should validate guests email and name' do
    assert_no_difference('Guest.count') do
      post api_v1_guests_url, params: { guest: { email: '', name: '' } }, as: :json
    end
    json_response = JSON.parse(@response.body)
    assert_equal json_response["name"], ["can't be blank"]
    assert_equal json_response["email"], ["can't be blank", "is invalid"]
  end

  test "should show guest" do
    get api_v1_guest_url(@guest), as: :json
    assert_response :success
  end
end
