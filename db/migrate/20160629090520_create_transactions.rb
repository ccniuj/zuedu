class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :order, index: true
      t.hstore :params
      t.string :trade_number

      t.timestamps null: false
    end
    add_foreign_key :transactions, :orders
    add_index :transactions, :trade_number, unique: true
  end
end
