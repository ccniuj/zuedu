class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart
  belongs_to :order
  before_destroy :check_order_existence
  enum gender: [ 'male', 'female' ]
  enum food_preference: ['normal', 'veggie', 'no_beef', 'other']

  validates :name, :birth, :gender, :ss_number, 
            :school, :grade, :food_preference, 
            :parent_phone_number, :parent_email, 
            presence: true, 
            on: :update
  validates :parent_phone_number, format: { with: /foo/,
            message: "foo" }

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
