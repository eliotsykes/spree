class MoveProductsMetadata < ActiveRecord::Migration
  def self.up
    products_with_metadata = Product.all(
      :conditions => 'meta_description is not null or meta_keywords is not null',
      :select => 'id, meta_description, meta_keywords',
      :readonly => true)
    products_with_metadata.each do |product|
      Metadata.create(:metadatable => product, 
        :description => product.meta_description,
        :keywords => product.meta_keywords)
    end
    remove_column "products", "meta_description"
    remove_column "products", "meta_keywords"
  end

  def self.down
    add_column "products", "meta_description", :string
    add_column "products", "meta_keywords", :string
    metadatas = Metadata.all(:conditions => "metadatable_type = 'Product'")
    metadatas.each do |metadata|
      product = metadata.metadatable
      product.meta_description = metadata.description
      product.meta_keywords = metadata.keywords
      product.save!
      metadata.delete
    end
  end
end
