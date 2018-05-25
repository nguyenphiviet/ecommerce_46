class ProductsController < ApplicationController
  before_action :load_categories, only: %i(show index)
  before_action :load_ratings, only: %i(show)
  after_action :load_comments,only: %i(show)

  def show
    @product = Product.find_by id: params[:id]
    @favourite = current_user.favourites.find_by product_id: @product.id if
      logged_in? && current_user.favouriting?(@product)
    return if @product
    flash[:danger] = t "cant_find_product"
    redirect_to root_url
  end

  def index
    @products = Product.search_by_name params[:name] if params[:name]
  end

  private

  def load_comments
    @comments = @product.comments
      .page(params[:page]).per(Settings.paginate.comment_perpage)
    @comment = current_user.comments.build if logged_in?
  end

  def load_ratings; end

  def load_categories
    @categories = Category.all
  end
end
