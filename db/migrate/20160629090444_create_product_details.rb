class CreateProductDetails < ActiveRecord::Migration
  def change
    create_table :product_details do |t|
      t.references :product, index: true
      t.string :description
      t.date :from
      t.date :to

      t.timestamps null: false
    end
    add_foreign_key :product_details, :products
  end
end
