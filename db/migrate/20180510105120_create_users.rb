class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email, unique: true
      t.string :name
      t.string :address
      t.string :phone
      t.date :date_of_birth
      t.string :password_digest
      t.string :remember_digest
      t.integer :permission, null: false, default: 0
      t.string :activation_digest
      t.boolean :activated, default: false
      t.datetime :activated_at
      t.timestamps
    end
  end
end
