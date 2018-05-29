module ApplicationHelper
  def find_product_by_id id
    @product = Product.find_by id: id
  end

  def index_for counter, page, per_page
    (page - 1) * per_page + counter + 1
  end
end
