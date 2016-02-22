class CreateHotelsFacilities < ActiveRecord::Migration

  def self.up
    create_table :hotels_facilities, :id => false do |t|
        t.references :hotel
        t.references :hotel_facility
    end
    add_index :hotels_facilities, [:hotel_facility_id, :hotel_id]
    add_index :hotels_facilities, :hotel_id
  end

  def self.down
    drop_table :hotels_facilities
  end
end
