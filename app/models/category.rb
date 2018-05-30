class Category < ApplicationRecord
  has_many :products

  default_scope ->{where(accepted: :true)}
  scope :priority_asc, ->{order priority: :asc}

  validates :name, presence: true, uniqueness: {case_sensitive: false},
    length: {maximum: Settings.category.name.max_length}
  validates :priority, numericality:
    {greater_than_or_equal_to: Settings.category.priority.min_value,
      only_integer: true}
end
