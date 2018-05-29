class OrdersController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: %(index create)
  # after_action :update_quantity, only: :create

  def index
    @cart = session[:cart]
    @order = current_user.orders.build
    current_cart.each do |item|
      @order.order_details.build(quantity: item["quantity"], price: item["price"],
        product_id: item["product_id"])
    end
  end

  def create
    @order = current_user.orders.build order_params
    @order.status = Order.statuses[:pending]
    @order.save
    session.delete :cart
    flash[:success] = t "order_success"
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
    params.require(:order).permit(:name, :phone, :address, :note,
      order_details_attributes: [:id, :quantity, :price, :order_id, :product_id])
  end

  def redirect_to_homepage
    flash[:error] = t "error"
    redirect_to root_path
  end
end
