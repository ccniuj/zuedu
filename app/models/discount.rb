class Discount < ActiveRecord::Base
  has_many :orders, dependent: :nullify
  after_create :generate_key
  enum discount_type: [ 'substraction', 'early_bird' ]

  def generate_key
  	update key: SecureRandom.hex
  end
end
