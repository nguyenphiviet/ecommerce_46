class StaticPagesController < ApplicationController
  def home
    @lastest_products = Product.lastest_product Settings.product.limit
    @categories = Category.all
    @hot_products = Product.hot_product_by_month Settings.product.lastest_month
  end
end
