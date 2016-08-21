class OrderSerializer < ActiveModel::Serializer
  attributes :id, 
             :first_name,
             :last_name,
             :payment,
             :email,
             :address,
             :line_items,
             :created_at

  def line_items
    object.line_items.sort.map do |item|
      LineItemSerializer.new item
    end
  end
end
