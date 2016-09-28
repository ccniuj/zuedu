class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :member, index: true
      t.references :discount, index: true
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :address
      t.integer :payment, default: 0

      t.timestamps null: false
    end
    add_foreign_key :orders, :members
    add_foreign_key :orders, :discounts
  end
end
