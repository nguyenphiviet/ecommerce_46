class FavouritesController < ApplicationController
  before_action :logged_in_user, :load_product, only: %i(create destroy)
  after_action :action_completed, only: %i(create destroy)

  def create
    unless current_user.favouriting? @product
      @favourite = current_user.favourite @product
      flash.now[:success] = t ".success"
    end
  end

  def destroy
    if current_user.favouriting? @product
      current_user.unfavourite @product
      flash.now[:success] = t ".success"
    end
  end

  private

  def load_product
    @product = Product.find_by id: params[:product_id]
    if @product.nil?
      respond_to do |format|
        format.html {redirect_to request.referrer}
        format.js
      end
    end
  end

  def action_completed
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.js
    end
  end
end
