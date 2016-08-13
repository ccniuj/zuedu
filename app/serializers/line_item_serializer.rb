class LineItemSerializer < ActiveModel::Serializer
  attributes :id, 
             :product_id, 
             :product_name, 
             :unit_price,
             :name,

  def product_id
    object.product.id
  end

  def product_name
    object.product.name
  end

  def unit_price
    object.unit_price.to_i
  end
end
