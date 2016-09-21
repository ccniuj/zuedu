class ProductDetailSerializer < ActiveModel::Serializer
  attributes :id, :description, :from, :to
end
