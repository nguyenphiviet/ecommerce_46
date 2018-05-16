class Item
  attr_accessor :product_id, :name, :quantity, :price, :image

  def initialize product_id, name, quantity, price, image
    @product_id = product_id
    @quantity = quantity
    @price = price
    @image = image
    @name = name
  end

end
