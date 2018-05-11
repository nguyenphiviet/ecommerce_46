class User < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :suggestions, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :ratings
  before_save {self.email = email.downcase}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum:255},
  format: {with: VALID_EMAIL_REGEX},
  uniqueness: {case_sensitive: false}
end
