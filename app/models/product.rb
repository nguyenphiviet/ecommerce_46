class Product < ApplicationRecord
  belongs_to :provider
  belongs_to :category
  has_many :comments
  has_many :ratings
  has_many :favourites
  has_many :order_details
end
