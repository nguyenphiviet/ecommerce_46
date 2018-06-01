class Product < ApplicationRecord
  belongs_to :provider
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :order_details
  has_many :images
  accepts_nested_attributes_for :images, allow_destroy: true,
    reject_if: :all_blank

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

  scope :lastest_product, ->(number){order(created_at: :desc).limit(number)}
  scope :search_by_name, ->(name){where (" name like ?"), "%#{name}%"}
  scope :newest, ->{order created_at: :desc}
  scope :oldest, ->{order created_at: :asc}

  def self.hot_product_by_month month
    product_ids = "SELECT `order_details`.`product_id`
                   FROM order_details
                   WHERE (order_details.created_at >= DATE_SUB(CURRENT_DATE(),INTERVAL " + month.to_s +  " MONTH))
                   GROUP BY `order_details`.`product_id`
                   ORDER BY sum(order_details.quantity) DESC"
    Product.where("id IN (#{product_ids})").limit(Settings.product.limit)
  end

  def self.to_csv
    attributes = %w{id name price}
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |user|
        csv << attributes.map{|attri| user.send(attri)}
      end
    end
  end

  def self.custom_search params
    filter = ""
    if !params[:name].blank?
      filter = filter + "name LIKE '%#{params[:name]}%'"
    end
    if !params[:category_id].blank?
      filter = filter + " and category_id = #{params[:category_id]}"
    end
    if !params[:provider_id].blank?
      filter = filter + " and provider_id = #{params[:provider_id]}"
    end
    if filter.blank?
      all
    else
      where(filter)
    end
  end
end
