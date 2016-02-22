class CreateRoomsFacilities < ActiveRecord::Migration
  def change
    create_table :rooms_facilities, :id => false do |t|
      t.references :room
      t.references :room_facility
    end

    add_index :rooms_facilities, [:room_facility_id, :room_id]
    add_index :rooms_facilities, :room_id
  end
end
