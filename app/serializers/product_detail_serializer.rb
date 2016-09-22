class ProductDetailSerializer < ActiveModel::Serializer
  attributes :id, :product_id, :description, :from, :to
end
