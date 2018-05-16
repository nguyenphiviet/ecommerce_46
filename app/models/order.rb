class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details
  accepts_nested_attributes_for :order_details, reject_if: :all_blank
  validates :name, presence: true
  validates :phone, presence: true, length: {maximum: Settings.user.phone.max_length}
  validates :address, presence: true, length: {maximum: Settings.user.address.max_length}
  enum status: [:deleted, :pending, :shipped]
  after_save :update_quantity_product

  private

  def update_quantity_product
    order = Order.find_by id: self.id
    items = order.order_details
    items.each do |od|
      product = Product.find_by id: od.product_id
      quantity_update = product.quantity.to_i - od.quantity.to_i
      Product.where(:id => od.product_id).update_all(:quantity => quantity_update)
    end
  end
end
