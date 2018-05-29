class Product < ApplicationRecord
  belongs_to :provider
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :order_details

  enum status: {normal: 0, hot: 1}
  mount_uploader :image, ImageUploader

  validates :name, presence: true, uniqueness: {case_sensitive: false},
    length: {maximum: Settings.product.name.max_length}
  validates :price, presence: true,
     numericality: {less_than_or_equal_to: Settings.product.max_price,
      greater_than_or_equal_to: Settings.product.min_price, only_integer: true}
  validates :quantity, numericality:
    {less_than_or_equal_to: Settings.product.max_quantity,
      greater_than_or_equal_to: Settings.product.min_quantity,
      only_integer: true}
  validate :image_size
  validates :category_id, presence: true
  validates :provider_id, presence: true

  scope :lastest_product, ->(number){order(created_at: :desc).limit(number)}
  scope :search_by_name, ->(name){where (" name like ?"), "%#{name}%"}

  def self.hot_product_by_month month
    product_ids = "SELECT `order_details`.`product_id`
                   FROM order_details
                   WHERE (order_details.created_at >= DATE_SUB(CURRENT_DATE(),INTERVAL " + month.to_s +  " MONTH))
                   GROUP BY `order_details`.`product_id`
                   ORDER BY sum(order_details.quantity) DESC"
    Product.where("id IN (#{product_ids})").limit(Settings.product.limit)
  end

  private

  def image_size
    errors.add(:image, t("admin.products.new.min_size_image")) if
      image.size > 1.megabytes
  end
end
