class Admin::CategoriesController < Admin::BaseController
  before_action :load_category, except: %i(new index create)

  def index
    @categories = Category.select(:id, :name, :priority).enable
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
      flash.now[:error] = t ".fail"
      render :new
    end
  end

  def edit; end

  def update
    if @category.update_attributes category_params
      flash[:success] = t ".success"
      redirect_to admin_categories_path
    else
      flash.now[:error] = t ".fail"
      render :new
    end
  end

  def destroy
    if @category.update_attributes enable: false
      flash.now[:success] = t ".success"
      respond_to do |format|
        format.html {redirect_to admin_categories_path}
        format.js
      end
    else
      flash.now[:error] = t ".fail"
      respond_to do |format|
        format.html {redirect_to admin_categories_path}
        format.js
      end
    end
  end

  private

  def category_params
    params.require(:category).permit :name, :priority, enable: true
  end

  def load_category
    @category = Category.find_by id: params[:id]
    unless @category
      flash.now[:error] = t ".find_category"
      respond_to do |format|
        format.html {render file: "public/404.html", layout: true}
        format.js {render "admin/categories/load_category.js.erb"}
      end
    end
  end
end
