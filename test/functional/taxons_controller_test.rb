require 'test_helper'

class TaxonsControllerTest < ActionController::TestCase
  
  context "on" do
    setup do
      @taxonomy = Factory :taxonomy
      @taxon = Factory :taxon, :taxonomy => @taxonomy  
    end
    context "get to :show" do
      setup do
        get :show, :id => ['brands']
      end
      should_respond_with :success
      should_not_set_the_flash
      should_render_page_without_metadata [:description, :keywords]
      should_render_page_with_metadata(
        :before => lambda { @taxon.update_attribute(:metadata, Factory(:metadata)) }, 
        :title => 'Spree Demo Site', :description => 'Description', 
        :keywords => 'keyword1, keyword2')
    end
  end
  
end
