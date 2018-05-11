class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :address
      t.string :phone
      t.date :date_of_birth
      t.integer :type

      t.timestamps
    end
  end
end
