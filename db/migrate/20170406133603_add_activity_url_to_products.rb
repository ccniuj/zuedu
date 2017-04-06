class AddActivityUrlToProducts < ActiveRecord::Migration
  def change
    add_column :products, :activityUrl, :string
  end
end
