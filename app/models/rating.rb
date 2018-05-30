class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :product

  after_save :update_product_rate_average

  validates :point, presence: true, inclusion: Settings.rating.point,
    numericality: {only_integer: true}

  scope :rating_average, ->(product_id){where(product_id: product_id).average(:point)}

  private

  def update_product_rate_average
    product.rate_average = Rating.rating_average product_id
    product.save
  end
end
