class RatingsController < ApplicationController
  before_action :logged_in_user

  def create
    if Product.exists? params[:product_id]
      @rating = current_user.ratings.build rating_params
      @product = Product.find params[:product_id] if @rating.save
    end
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.js
    end
  end

  private

  def rating_params
    params[:rating][:product_id] = params[:product_id]
    params.require(:rating).permit :point, :product_id
  end
end
