class Product < ActiveRecord::Base
  has_many :line_items
  has_many :product_details
  before_destroy :check_line_items_presence
  
private

  def check_line_items_presence
    unless line_items.empty?
      errors.add(:line_items, :present)
      false
    end
  end
end
