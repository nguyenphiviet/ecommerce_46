class CategoriesController < ApplicationController
  before_action :load_products, only: %i(show)
  before_action :load_categories, only: %i(show index)

  private

  def load_products
    category = Category.find_by id: params[:id]
    @result = category.products if category
    @products = @result.page(params[:page]).per(Settings.paginate.product_perpage)
  end

  def load_categories
    @categories = Category.all
  end
end
