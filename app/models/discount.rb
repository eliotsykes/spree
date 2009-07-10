class Discount < ActiveRecord::Base    
  after_save :update_credit
  
  has_one :credit, :as => :creditable, :dependent => :destroy
  belongs_to :coupon
  belongs_to :checkout
  
  validates_presence_of :coupon_id
  validates_presence_of :checkout_id   

  def update_credit    
    return credit.update_attribute("amount") if credit  
    self.credit = Credit.create(:amount => amount, :description => coupon.name, :order => checkout.order)
  end
end
