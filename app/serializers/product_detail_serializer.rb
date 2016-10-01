class ProductDetailSerializer < ActiveModel::Serializer
  attributes :id, :product_id, :description, :place, :price, :inventory, :date_from, :date_to, :time_from, :time_to

  def time_from
  	object.time_from&.strftime '%H:%M'
  end

  def time_to
  	object.time_to&.strftime '%H:%M'
  end
end
