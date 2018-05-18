class Admin::BaseController < ActionController::Base
  layout "admin/layouts/admin"
  include SessionsHelper

  before_action :require_admin

  def require_admin
    redirect_to root_path unless logged_in? && current_user.admin?
  end
end
