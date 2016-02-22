class Room < ActiveRecord::Base
  belongs_to :hotel
  belongs_to :room_type
  has_many :orders
  has_and_belongs_to_many :room_facilities, join_table: "rooms_facilities"

  validates :price, numericality: { greater_than_or_equal_to: 0 },
                    presence: true
end
