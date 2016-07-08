class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :inventory
end
