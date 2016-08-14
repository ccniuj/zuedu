class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart
  belongs_to :order
  before_destroy :check_order_existence
  enum gender: [ 'male', 'female' ]
  enum food_preference: ['normal', 'veggie', 'no_beef', 'other']

  def price
    unit_price
  end

private
  def check_order_existence
    unless order_id.nil?
      errors.add(:order, :is_not_empty)
      false
    end
  end
end
