class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :inventory, :description, :product_details

  def product_details
  	case instance_options[:template]
    when 'edit'
      object.product_details.sort.map do |pd|
        ProductDetailSerializer.new pd
      end
    else
      []
    end
  end
end
