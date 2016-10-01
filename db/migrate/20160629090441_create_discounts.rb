class CreateDiscounts < ActiveRecord::Migration
  def change
    create_table :discounts do |t|
      t.string :name, default: ''
      t.string :key, default: ''
      t.integer :prerequisite, default: 0
      t.integer :discount_type, default: 0
      t.float :factor, default: 0.0
      t.date :date_from, default: Time.now
      t.date :date_to, default: Time.now

      t.timestamps null: false
    end
  end
end
