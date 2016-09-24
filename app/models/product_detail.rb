class ProductDetail < ActiveRecord::Base
  belongs_to :product
  has_many :line_items
end
