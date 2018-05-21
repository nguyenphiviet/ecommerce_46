class CommentsController < ApplicationController
  before_action :load_product, only: %i(create edit destroy)

  def create
    @comment = current_user.comments.build comment_params
    respond_to do |format|
      if @comment.save
        format.html {redirect_to @product}
        format.js
      else
        flash[:warning] = t "create_fail"
        format.html {render @product}
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit :content, :product_id
  end

  def load_product
    @product = Product.find_by id: params[:product_id] if params[:product_id]
  end
end
