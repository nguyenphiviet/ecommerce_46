module ApplicationHelper
  def find_product_by_id id
    @product = Product.find_by id: id
  end
end
