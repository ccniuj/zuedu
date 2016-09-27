class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :product_detail
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
  validates :parent_phone_number, format: { with: /\d{10}/ }, 
            on: :update

  def price
    unit_price
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names.map { |c| I18n.t "activerecord.attributes.line_item.#{c}" }
      includes(:product, :product_detail, :cart, :order).each do |line_item|
        csv << column_names.map do |col|
                 case col
                 when 'product_id'
                   line_item.product.name
                 when 'product_detail_id'
                   line_item.product_detail.description
                 when 'gender'
                   I18n.t "activerecord.attributes.line_item.gender_value.#{line_item.gender}"
                 when 'food_preference'
                   I18n.t "activerecord.attributes.line_item.food_preference_value.#{line_item.food_preference}"
                 else
                   line_item[col]
                 end
               end
      end
    end
  end

private
  def check_order_existence
    unless order_id.nil?
      errors.add(:order, :is_not_empty)
      false
    end
  end
end
