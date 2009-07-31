class Metadata < ActiveRecord::Base
  belongs_to :metadatable, :polymorphic => true
  
  def before_save
    if blank?
      delete
      return false
    end
    return true
  end
  
  def blank?
    return keywords.blank? && description.blank?
  end
  
end
