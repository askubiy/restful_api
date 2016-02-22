class BookingPeriod < ActiveRecord::Base
  belongs_to :hotel
  belongs_to :room
end
