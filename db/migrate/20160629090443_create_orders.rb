class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :member, index: true
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :address

      t.timestamps null: false
    end
    add_foreign_key :orders, :members
  end
end
