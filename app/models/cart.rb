class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  has_many :orders
  belongs_to :member
  delegate :empty?, to: :line_items

  def price
    line_items.to_a.sum(&:price)
  end

  def matchable_discount
    DiscountMatcher.match self
  end
end
