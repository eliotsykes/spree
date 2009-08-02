class ProductsController < Spree::BaseController
  before_filter(:setup_admin_user) unless RAILS_ENV == "test"

  resource_controller
  helper :taxons
  before_filter :load_data, :only => :show
  actions :show, :index

  index do
    before do
      @product_cols = 3
      load_metadata
    end
  end

  def change_image
    @product = Product.available.find_by_param(params[:id])
    img = Image.find(params[:image_id])
    render :partial => 'image', :locals => {:image => img}
  end

  def home?
    '/' == request.path
  end
  
  private
  def load_metadata
    self.metadata = Metadata.for_home if home?
  end
  
  def setup_admin_user
    return if admin_created?
    flash[:notice] = I18n.t(:please_create_user)
    redirect_to signup_url
  end
  
  def load_data  
	  load_object  
		@selected_variant = @product.variants.detect { |v| v.in_stock || Spree::Config[:allow_backorders] }
    return unless permalink = params[:taxon_path]
    @taxon = Taxon.find_by_permalink(params[:taxon_path].join("/") + "/")	
  end
  
  def collection
    search_query = Product.active

    if !params[:taxon].blank? && (@taxon = Taxon.find_by_id(params[:taxon]))
      search_query = search_query.scoped({
          :conditions => [
            "products.id in (select product_id from products_taxons where taxon_id in (?))",
            ([@taxon] + @taxon.descendents).map(&:id)
          ]})
    end

    @search = search_query.new_search(params[:search])

    @search.per_page ||= Spree::Config[:products_per_page]
    @search.include = {:variants => :images}

    @product_cols = 3
    @products ||= @search.all
  end
end
