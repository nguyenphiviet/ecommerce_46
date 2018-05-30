class AddStatusToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :priority, :integer, default: 0
    add_column :categories, :accepted, :boolean, default: true
  end
end
