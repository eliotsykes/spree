require 'test_helper'

class CouponTest < ActiveSupport::TestCase
  should_validate_presence_of :code
  should_validate_presence_of :calculator
  
  context "instance" do
    setup do
      @checkout = Factory(:checkout)
      @coupon = Factory(:coupon)
    end
    context "create_discount" do
      setup do
        @coupon.create_discount(@checkout)
      end 
      should_change "@checkout.discounts.count", :by => 1
    end    
    context "when expired" do
      setup do 
        @coupon.expires_at = 3.days.ago
        @coupon.create_discount(@checkout)
      end
      should_not_change "Discount.count"
    end
    context "when usage_limit has been exceeded" do
      setup do
        @coupon.usage_limit = 0
        @coupon.create_discount(@checkout)
      end
      should_not_change "Discount.count"
    end
  end
end
       
class TestCalc
  def self.calculate_discount(checkout)    
    0.99
  end
end