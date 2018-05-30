class Admin::CategoriesController < Admin::BaseController
  def index
    @categories = Category.select(:id, :name, :priority, :accepted)
      .priority_asc.page(params[:page]).per(Settings.admin.list.per_page)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t ".success"
      redirect_to admin_categories_path
    else
      flash.now[:error] = t ".create_fail"
      render :new
    end
  end

  def update; end

  def destroy; end

  private

  def category_params
    params.require(:category).permit :name, :priority, :accepted
  end
end
