class OrderSerializer < ActiveModel::Serializer
  attributes :id, 
             :name,
             :member_id,
             :discount_key,
             :member_name,
             :first_name,
             :last_name,
             :payment,
             :price,
             :email,
             :address,
             :line_items,
             :transactions,
             :created_at

  def line_items
    object.line_items.sort.map do |item|
      LineItemSerializer.new item
    end
  end

  def transactions
    object.transactions.sort.map do |t|
      TransactionSerializer.new t
    end
  end

  def name
    "#{object.last_name}#{object.first_name}"
  end

  def member_name
    object.member&.name
  end

  def discount_key
    object.discount&.key
  end
end
