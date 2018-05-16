module ProductsHelper
  def show_image product
    image_tag(product.image, class: "img-responsive")
  end

end
