require 'test_helper'

class TaxonsControllerTest < ActionController::TestCase
  context "on get to :show" do
    setup do
      @taxonomy = Factory :taxonomy
      @taxon = Factory :taxon, :taxonomy => @taxonomy
    end
    context "taxon without metadata" do
      setup do
        get :show, :id => ['brands']
      end
      should_respond_with :success
      should "not output meta description tag" do
        assert_select 'meta[name="description"]', false
      end
      should "not output meta keywords tag" do
        assert_select 'meta[keywords="keywords"]', false
      end
    end
    context "taxon with metadata" do
      setup do
        @taxon.update_attribute :metadata, Factory(:metadata)
        get :show, :id => ['brands']
      end
      should_respond_with :success
      should "output meta description tag" do
        assert_select 'meta[name="description"]' do
          assert_select '[content=?]', 'Description'
        end
      end
      should "output meta keywords tag" do
        assert_select 'meta[name="keywords"]' do
          assert_select '[content=?]', 'keyword1, keyword2'
        end
      end
    end
  end
end
