class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.references :room_type
      t.references :hotel
      t.decimal :price, precision: 6, scale: 2

      t.timestamps null: false
    end
  end
end
