class OrdersController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: %(index create)

  def index
    @cart = session[:cart]
    @user = current_user
  end

  def create
    flash[:success] = "Order success"
    redirect_to root_path
  end

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "require_login"
      redirect_to login_url
    end
  end

  def correct_user
    error_redirect unless current_user
  end

  def order_params
    params.require(:order).permit :name, :phone, :address,
    :note
  end
end
