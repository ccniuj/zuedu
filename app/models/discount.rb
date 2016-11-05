class Discount < ActiveRecord::Base
  has_many :orders, dependent: :nullify
  after_create :generate_key
  enum discount_type: [ 'group_discount', 'earlybird_discount', 'group_and_earlybird_discount' ]
  validates :name, :discount_type, presence: true 

  def generate_key
  	update key: SecureRandom.hex(4)
  end
end
