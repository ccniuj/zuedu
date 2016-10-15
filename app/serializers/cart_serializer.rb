class CartSerializer < ActiveModel::Serializer
  attributes :id, :count, :price, :line_items, :matchable_discount_name, :matchable_discount_factor
  
  def count
    object.line_items.size
  end

  def line_items
    case instance_options[:template]
    when 'index'
      object.line_items.sort.map do |item|
        LineItemSerializer.new item
      end
    when 'edit'
      object.line_items.sort.map do |item|
        LineItemSerializer.new item
      end
    else
      []
    end
  end

  def price
    object.price.to_i
  end

  def matchable_discount_name
    object.matchable_discount&.name
  end

  def matchable_discount_factor
    object.matchable_discount&.factor
  end
end
