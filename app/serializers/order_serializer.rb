class OrderSerializer < ActiveModel::Serializer
  attributes :id, 
             :first_name,
             :last_name,
             :email,
             :address,
             :created_at
end
