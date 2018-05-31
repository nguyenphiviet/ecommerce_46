class Category < ApplicationRecord
  has_many :products

  scope :enable, ->{where enable: true}
  scope :priority_asc, ->{order priority: :asc}

  validates :name, presence: true,
    length: {maximum: Settings.category.name.max_length}
  validates :priority, numericality:
    {greater_than_or_equal_to: Settings.category.priority.min_value,
      only_integer: true}
end
