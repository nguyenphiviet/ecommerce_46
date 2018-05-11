class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.integer :quantity
      t.string :color
      t.text :description
      t.text :guarantee_info
      t.integer :status
      t.string :image
      t.float :rate_average
      t.references :category, foreign_key: true
      t.references :provider, foreign_key: true


      t.timestamps
    end
  end
end
