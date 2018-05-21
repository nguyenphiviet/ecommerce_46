class CategoriesController < ApplicationController
  before_action :find_products_by_category, only: %i(show)


  private

    def find_products_by_category
      category = Category.find_by id: params[:id]
      @products = category.product
      @categories = Category.all
    end
end
