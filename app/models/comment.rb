class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :content, presence: true, length: {maximum: Settings.comment.max_length}
  scope :sort_by_time, ->{order(created_at: :desc)}
end
