class OrderDetail < ApplicationRecord
  belongs_to :product
  belongs_to :order

  def price_product_order
    product.price
  end

  def total_price
    price * quantity
  end
end
