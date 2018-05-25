class CommentsController < ApplicationController
  before_action :load_product
  before_action :load_comment, only: %i(edit update destroy)

  def create
    @comment = current_user.comments.build comment_params
    @comment.product_id = params[:product_id]
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

  def edit; end

  def update
    respond_to do |format|
      if @comment.update comment_params
        format.html {redirect_to @product}
        format.js
      else
        flash[:danger] = t "update_fail"
        format.html {render :edit}
      end
    end
  end

  def destroy
    respond_to do |format|
      if @comment.destroy
        format.html {redirect_to @product}
        format.js
      else
        flash[:danger] = t "delete_fail"
        format.html {redirect_to @product}
      end
    end
  end

  def edit; end

  private

  def comment_params
    params.require(:comment).permit :content
  end

  def load_product
    @product = Product.find_by id: params[:product_id]
    error_redirect unless @product
  end

  def load_comment
    @comment = @product.comments.find_by id: params[:id]
    error_redirect unless @comment
  end
end
