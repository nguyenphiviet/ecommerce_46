module CommentsHelper
  def can_edit_comment? comment
    current_user.comments.include?(comment)
  end
end
