module ProductsHelper
  def show_image product
    if product.image.present?
      image_tag(product.image, class: "img-responsive")
    end
  end
end
