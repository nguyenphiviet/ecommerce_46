class Admin::UsersController < Admin::BaseController
  def index
    @users = User.select(:id, :name, :email, :address, :phone, :activated)
      .order(:name).page(params[:page]).per(Settings.admin.list.per_page)
  end

  def edit; end

  def update; end

  def destroy; end
end
