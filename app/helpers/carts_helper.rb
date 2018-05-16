module CartsHelper

  def current_cart
    @current_cart = session[:cart] if session[:cart]
  end

  def total_cart
    total = 0
    session[:cart].each do |item|
      total += (item["price"].to_i * item["quantity"].to_i) if item
    end
    total
  end

  def update_quantity
    current_cart.each do |item|
      product = Product.find_by id: item["product_id"]
      quantity_update = product.quantity.to_i - item["quantity"].to_i
      Product.where(:id => item["product_id"]).update_all(:quantity => quantity_update)
    end
  end
end
