class Admin::ProductsController < Admin::BaseController
  def index
    @products = Product.select(:id, :name, :price, :quantity, :status,
      :rate_average, :category_id, :provider_id).newest
      .page(params[:page]).per(Settings.admin.list.per_page)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:success] = t ".success"
      redirect_to admin_products_path
    else
      flash.now[:error] = t ".create_fail"
      render :new
    end
  end

  def edit; end

  def update; end

  private

  def product_params
    params.require(:product).permit :name, :price, :quantity,
      :status, :description, :guarantee_info,
      :category_id, :provider_id,
      images_attributes: [:id, :image_url, :_destroy]
  end
end
