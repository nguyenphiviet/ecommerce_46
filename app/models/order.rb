class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details
  validates :name, presence: true
  validates :phone, presence: true, length: {maximum: Settings.user.phone.max_length}
  validates :date_of_birth, presence: true, length: {maximum: Settings.user.date_of_birth.max_length}
end
