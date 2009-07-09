class Coupon < ActiveRecord::Base
  has_many :discounts 
  #has_many :credits, :through => :discounts, :source => :coupon
  #has_many :checkouts, :through => :discounts
  #has_many :orders, :through => :credits
  #has_many :users, :through => :orders
  
  validates_presence_of :calculator
  validates_presence_of :code
  
  def create_discount(checkout)
    return unless amount = calculator.constantize.calculate_discount(checkout)
    return if expires_at and Time.now > expires_at
    return if usage_limit and discounts.count >= usage_limit
    checkout.discounts.create(:coupon => self, :checkout => checkout, :amount => amount)
  end
  
  #def can_apply?(order)
  #  true
  #end
end
