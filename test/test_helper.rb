ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'

class ActiveSupport::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
end

I18n.locale = "en-US"

ActionController::TestCase.class_eval do
  # special overload methods for "global"/nested params
  [ :get, :post, :put, :delete ].each do |overloaded_method|
    define_method overloaded_method do |*args|
      action,params,extras = *args
      super action, params || {}, *extras unless @params
      super action, @params.merge( params || {} ), *extras if @params
    end
  end
  
  # Should for ensuring a rendered page does not contain meta tags with the
  # given names. e.g.
  # should_render_page_without_metadata [:description, :keywords]
  def self.should_render_page_without_metadata(metadata_names)
    metadata_names.each do |name|
      should "not have metatag #{name}" do
        assert_select "meta[name='#{name}']", false
      end
    end
  end
  
  # Overidden from shoulda to allow use of the :before option
  def self.should_render_page_with_metadata(options)
    before_block = options.delete(:before)
    should "render page with metadata", :before =>  before_block do
      assert_metadata options
    end
  end
  
  # Asserts that a title and metadata are present as given in the options, e.g.
  # assert_metadata :title => 'Page title',
  #  :description => 'meta tag description goes here',
  #  :keywords => 'keyword, another keyword'
  def assert_metadata(options)
    options.each do |key, value|
      if key.to_sym == :title
        assert_select "title", value
      else
        assert_select "meta[name=?][content#{"*" if value.is_a?(Regexp)}=?]", key, value
      end
    end
  end
  
end

def setup
  super
  @params = {}
end

class TestCouponCalc
  def self.calculate_discount(checkout)    
    0.99
  end
end