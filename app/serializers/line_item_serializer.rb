class LineItemSerializer < ActiveModel::Serializer
  attributes :id, :product_id, :name, :unit_price, :quantity
  def product_id
    object.product.id
  end

  def name
    object.product.name
  end
end
