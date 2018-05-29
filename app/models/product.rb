class Product < ApplicationRecord
  belongs_to :provider
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :order_details
  has_many :images
  accepts_nested_attributes_for :images,
    reject_if: ->(attrs) {attrs['image_url'].blank?}

  enum status: {normal: 0, hot: 1}

  validates :name, presence: true, uniqueness: {case_sensitive: false},
    length: {maximum: Settings.product.name.max_length}
  validates :price, presence: true,
     numericality: {less_than_or_equal_to: Settings.product.max_price,
      greater_than_or_equal_to: Settings.product.min_price, only_integer: true}
  validates :quantity, numericality:
    {less_than_or_equal_to: Settings.product.max_quantity,
      greater_than_or_equal_to: Settings.product.min_quantity,
      only_integer: true}
  validates :category_id, presence: true
  validates :provider_id, presence: true
  validate {images_empty}

  scope :lastest_product, ->(number){order(created_at: :desc).limit(number)}
  scope :search_by_name, ->(name){where (" name like ?"), "%#{name}%"}
  scope :newest, ->{order created_at: :desc}

  def self.hot_product_by_month month
    product_ids = "SELECT `order_details`.`product_id`
                   FROM order_details
                   WHERE (order_details.created_at >= DATE_SUB(CURRENT_DATE(),INTERVAL " + month.to_s +  " MONTH))
                   GROUP BY `order_details`.`product_id`
                   ORDER BY sum(order_details.quantity) DESC"
    Product.where("id IN (#{product_ids})").limit(Settings.product.limit)
  end

  private

  def images_empty
    errors.add(:images, :blank,
      message: I18n.t("admin.products.new.not_empty")) unless
      images.count > 0
  end
end
