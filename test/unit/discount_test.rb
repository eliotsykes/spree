require 'test_helper'

class DiscountTest < ActiveSupport::TestCase
  should_validate_presence_of :checkout_id
  should_validate_presence_of :coupon_id 
  should_validate_presence_of :amount
  should_validate_numericality_of :amount
end
