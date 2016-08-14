class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.references :product, index: true
      t.references :cart, index: true
      t.references :order, index: true
      t.decimal :unit_price, default: 0
      t.string :name, default: ''
      t.date :birth
      t.integer :gender, default: 0
      t.string :ss_number, default: ''
      t.string :school, default: ''
      t.integer :grade, default: 0
      t.integer :food_preference, default: 0
      t.string :note, default: ''

      t.timestamps null: false
    end
    add_foreign_key :line_items, :products
    add_foreign_key :line_items, :carts
    add_foreign_key :line_items, :orders
  end
end
