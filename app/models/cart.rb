class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  has_many :orders
  delegate :empty?, to: :line_items

  def price
    line_items.to_a.sum(&:price)
  end
end