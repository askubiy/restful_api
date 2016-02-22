class Hotel < ActiveRecord::Base
  has_many :rooms
  has_many :booking_periods
  has_and_belongs_to_many :hotel_facilities, join_table: "hotels_facilities"
end
