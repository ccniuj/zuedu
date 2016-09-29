class Discount < ActiveRecord::Base
  has_many :orders, dependent: :nullify
  after_create :generate_key
  enum discount_type: [ 'group_discount', 'early_bird', 'staff_discount' ]

  def generate_key
  	update key: SecureRandom.hex
  end
end
