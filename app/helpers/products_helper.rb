module ProductsHelper
  def show_image product
    if product.images.present?
      image_tag product.images.first.image_url, class: "img-responsive"
    end
  end
end
