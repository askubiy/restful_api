class HotelFacility < ActiveRecord::Base
  has_and_belongs_to_many :hotels, join_table: "hotels_facilities"
end
