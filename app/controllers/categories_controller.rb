class CategoriesController < ApplicationController
  before_action :load_products, only: %i(show)
  before_action :load_categories, only: %i(show index)

  private

  def load_products
    category = Category.find_by id: params[:id]
    @products = category.products if category
  end

  def load_categories
    @categories = Category.all
  end
end
