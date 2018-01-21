require 'test_helper'

class HotelTest < ActiveSupport::TestCase
  test "validate email format" do
    hotel = Hotel.new(name: 'Sample', email: 'wrong_format', phone: '12345678')
    assert_not hotel.valid?
    assert_equal  hotel.errors.messages[:email], ["is invalid"]
  end

  test 'validate phone field' do
    hotel = Hotel.new(name: 'Sample', email: 'wrong_format@yahoo.com', phone: '32432')
    assert_not hotel.valid?
    assert_equal  hotel.errors.messages[:phone], ["is too short (minimum is 6 characters)"]
  end
end
