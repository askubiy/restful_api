class RoomFacility < ActiveRecord::Base
  has_and_belongs_to_many :rooms, join_table: "rooms_facilities"
end
