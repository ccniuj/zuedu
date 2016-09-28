class CreateProductDetails < ActiveRecord::Migration
  def change
    create_table :product_details do |t|
      t.references :product, index: true
      t.string :description
      t.string :place
      t.date :date_from, default: Time.now
      t.date :date_to, default: Time.now
      t.time :time_from, default: '09:00'
      t.time :time_to, default: '17:00'

      t.timestamps null: false
    end
    add_foreign_key :product_details, :products
  end
end
