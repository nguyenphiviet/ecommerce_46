class AddStatusToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :priority, :integer, default: 1
    add_column :categories, :enable, :boolean, default: true
  end
end
