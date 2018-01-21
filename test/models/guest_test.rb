require 'test_helper'

class GuestTest < ActiveSupport::TestCase
  test "validate email format" do
    guest = Guest.new(name: 'Sample', email: 'wrong_format')
    assert_not guest.valid?
    assert_equal  guest.errors.messages[:email], ["is invalid"]
  end
end
