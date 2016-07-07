class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :inventory

  def price
    object.price.to_i
  end
end
