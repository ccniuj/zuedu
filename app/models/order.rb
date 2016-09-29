class Order < ActiveRecord::Base
  belongs_to :member
  belongs_to :discount
  has_many :line_items
  has_many :transactions
  after_commit :match_discount, on: :create
  before_destroy :can_not_be_destroyed
  enum payment: [ 'Credit', 'CVS' ]
  validates :first_name, :last_name, :payment, :email, :address, presence: true 

  def price
    if discount_id
      line_items.to_a.sum(&:price) - discount.factor
    else
      line_items.to_a.sum(&:price)
    end
  end

  def paid?
    transactions.find_by("params -> 'RtnCode' = '1' OR params -> 'TradeStatus' = '1'").present?
  end

private

  def match_discount
    group_discount_id = Discount.where('prerequisite <= ?', line_items.count).order(prerequisite: :DESC).first&.id
    update_column :discount_id, group_discount_id
  end

  def can_not_be_destroyed
    false
  end
end