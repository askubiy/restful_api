class CreateRoomFacilities < ActiveRecord::Migration
  def change
    create_table :room_facilities do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
