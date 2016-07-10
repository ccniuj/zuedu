class LineItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :unit_price, :quantity

  def name
    object.product.name
  end
end
