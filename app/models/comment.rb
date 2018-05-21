class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product
  validates :content, presence: true, length: {minimum: Settings.comment.min_length,maximum: Settings.comment.max_length}
  scope :sort_by_time, ->{order(created_at: :desc)}
end
