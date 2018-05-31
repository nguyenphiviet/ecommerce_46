class StaticPagesController < ApplicationController
  def home
    @lastest_products = Product.lastest_product Settings.home.limit
    @categories = Category.enable
    @hot_products = Product.hot_product_by_month Settings.home.limit
  end
end
