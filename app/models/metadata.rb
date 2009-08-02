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
  
  # Returns a transient instance containing the metadata for the home page
  def self.for_home
    Metadata.new(:description => Spree::Config[:home_metadata_description],
      :keywords => Spree::Config[:home_metadata_keywords]).freeze
  end
  
end
