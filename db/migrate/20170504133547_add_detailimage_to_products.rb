class AddDetailimageToProducts < ActiveRecord::Migration
  def change
  	add_column :products, :detailimage, :string
  end
end
