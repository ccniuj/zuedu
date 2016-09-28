class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :subtitle
      t.text :description
      t.text :dimension
      t.string :cover_image_url
      t.string :outline_image_url
      t.string :dimension_image_url
      t.string :target
      t.string :pricing
      t.integer :price
      t.integer :inventory

      t.timestamps null: false
    end
  end
end
