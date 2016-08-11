class CreateApplicants < ActiveRecord::Migration
  def change
    create_table :applicants do |t|
      t.references :product, index: true
      t.references :member, index: true
      t.references :order, index: true
      t.string :name
      t.string :phone_number

      t.timestamps null: false
    end
    add_foreign_key :applicants, :products
    add_foreign_key :applicants, :members
    add_foreign_key :applicants, :orders
  end
end
