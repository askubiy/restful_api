class Order < ActiveRecord::Base
  belongs_to :client
  belongs_to :hotel
  belongs_to :room

  validates_presence_of :start_date, :end_date, :phone, :customer_name, :hotel_id, :room_id
  validate :check_dates_available

  scope :overlapping, -> (interval){
    where("room_id = ? AND ((julianday(start_date) - julianday(?)) * (julianday(?) - julianday(end_date)) >= 1)",
    interval.room_id, interval.end_date, interval.start_date)
  }

  def overlaps?
    Order.overlapping(self).length > 0
  end

  def booking_period_available?
    if (self.room && self.room.hotel)
      (self.room.hotel.period_booking &&
        !self.room.hotel.booking_periods.where(start_date: self.start_date, end_date: self.end_date).blank?) ||
      (!self.room.hotel.period_booking)
    else
      return false
    end
  end

  def check_dates_available
    unless (!overlaps? && booking_period_available?)
      errors.add(:start_date, 'Date period is not available')
      errors.add(:end_date, 'Date period is not available')
    end
  end
end
