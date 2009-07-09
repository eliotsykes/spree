class Discount < ActiveRecord::Base    
  has_one :credit, :as => :creditable
  belongs_to :coupon
  belongs_to :checkout
  
  validates_presence_of :coupon_id
  validates_presence_of :checkout_id   
  validates_presence_of :amount
  validates_numericality_of :amount
  
  def validate
    #hack
    false
  end
end
