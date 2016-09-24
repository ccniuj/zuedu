class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :trade_number, :params
end
