class CreateBookingPeriods < ActiveRecord::Migration
  def change
    create_table :booking_periods do |t|
      t.date :start_date
      t.date :end_date
      t.references :hotel, index: true
      t.references :room, index: true

      t.timestamps null: false
    end
    add_foreign_key :booking_periods, :hotels
    add_foreign_key :booking_periods, :rooms
  end
end
