class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :phone
      t.string :address
      t.text :note
      t.integer :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
