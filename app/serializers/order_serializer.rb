class OrderSerializer < ActiveModel::Serializer
  attributes :id, :customer_name, :phone, :start_date, :end_date, :price
  has_one :client
end
