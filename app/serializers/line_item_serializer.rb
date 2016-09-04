class LineItemSerializer < ActiveModel::Serializer
  attributes :id, 
             :product_id, 
             :product_name, 
             :unit_price,
             :name,
             :birth,
             :gender,
             :ss_number,
             :school,
             :grade,
             :food_preference,
             :note,
             :parent_phone_number,
             :parent_email

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
