class DiscountSerializer < ActiveModel::Serializer
  attributes :id, 
             :name,
             :key,
             :discount_type,
             :discount_type_t,
             :prerequisite,
             :factor,
             :date_from,
             :date_to

  def discount_type_t
    I18n.t "activerecord.attributes.discount.discount_type_value.#{object.discount_type}"
  end
end
