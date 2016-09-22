class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :inventory, :description, :product_details

  def product_details
    object.product_details.sort.map do |pd|
      ProductDetailSerializer.new pd
    end
  end
end
