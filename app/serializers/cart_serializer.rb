class CartSerializer < ActiveModel::Serializer
  attributes :id, :count, :price, :line_items
  
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
end
