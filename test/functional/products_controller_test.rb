require 'test_helper'

class ProductsControllerTest < ActionController::TestCase

  context "on get to home page" do
    setup { get_home }
    should_respond_with :success
    should_assign_to :product_cols
    should_not_set_the_flash
    should_render_page_without_metadata [:description, :keywords]
    should_render_page_with_metadata(
      :before => lambda { configure_home_metadata(Factory(:metadata)) }, 
      :title => 'Spree Demo Site', :description => 'Description', 
      :keywords => 'keyword1, keyword2')
  end
  
  context "on" do
    setup { @product = Factory :product }
    context "get to :show" do
      setup { get :show, :id => @product.permalink }
      should_respond_with :success
      should_not_set_the_flash
      should_render_page_without_metadata [:description, :keywords]
      should_render_page_with_metadata(
        :before => lambda { @product.update_attribute(:metadata, Factory(:metadata)) }, 
        :title => 'Spree Demo Site', :description => 'Description', 
        :keywords => 'keyword1, keyword2')      
    end
  end
  
  def get_home
    get :index
    assert @request.path == '/'
    assert @controller.home?
  end
  
  def configure_home_metadata(metadata=nil)
    keywords = nil
    description = nil
    if (!metadata.blank?)
      keywords = metadata.keywords
      description = metadata.description
    end
    Spree::Config.set(:home_metadata_description => description,
      :home_metadata_keywords => keywords)
  end
  
end
