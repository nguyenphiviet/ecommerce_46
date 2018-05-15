class Product < ApplicationRecord
  belongs_to :provider
  belongs_to :category
  has_many :comments
  has_many :ratings
  has_many :favourites
  has_many :order_details

  validates :name, presence: true, length: {maximum: Settings.product.name.max_length}
  scope :lastest_product, ->(number){order(created_at: :desc).limit(number)}

  def self.hot_product_by_month month
    product_ids = "SELECT `order_details`.`product_id`
                   FROM order_details
                   WHERE (order_details.created_at >= DATE_SUB(CURRENT_DATE(),INTERVAL " + month.to_s +  " MONTH))
                   GROUP BY `order_details`.`product_id`
                   ORDER BY sum(order_details.quantity) DESC"
    Product.where("id IN (#{product_ids})").limit(Settings.product.limit)
  end
end
