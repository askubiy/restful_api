class RoomSerializer < ActiveModel::Serializer
  attributes :id, :room_type, :hotel, :price
end
