class ProductsController < ApplicationController
  before_action :load_product, except: %i(index create new)
  before_action :load_all_category, only: %i(new edit show)

  private
    def load_product
      @product = Product.find_by id: params[:id]
      return if @product
      flash[:danger] = t "cant_find_product"
      redirect_to root_url
    end

    def load_all_category
      @categories = Category.all
    end
end
