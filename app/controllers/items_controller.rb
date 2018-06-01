class ItemsController < ApplicationController
  before_action :load_product, only: %i(create)

  def show; end

  def create
    unless session[:cart].present?
      session[:cart] = []
    end
    item = Item.new(params[:product_id], @product.name, Settings.cart.default_quantity, @product.price, @product.image)
    index = session[:cart].find_index{|e| e["product_id"] == params[:product_id]}
    if index.nil?
      session[:cart] << item
      @cart = session[:cart]
    else
      quantity = session[:cart][index]["quantity"].to_i
      quantity += Settings.cart.default_quantity
      session[:cart][index]["quantity"] = quantity
    end
    respond_to do |format|
      format.html{redirect_to root_path}
      format.js
    end
  end

  def update
    index = session[:cart].find_index{|e| e["product_id"] == params[:id]}
    quantity_update = params["quantity"].to_i
    session[:cart][index]["quantity"] = quantity_update
    @total_price_item = quantity_update.to_i * session[:cart][index]["price"].to_i
    respond_to do |format|
      format.js
      format.html{redirect_to request.referrer}
    end
  end

  def destroy
    current_cart.delete_if {|item| item["product_id"] == params[:product_id]}
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.js
    end
  end

  private

  def load_product
    @product = Product.find_by id: params[:product_id]
    error_redirect unless @product
  end
end
