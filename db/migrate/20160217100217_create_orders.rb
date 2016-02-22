class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :customer_name
      t.string :phone
      t.date :start_date
      t.date :end_date
      t.decimal :price, precision: 6, scale: 2
      t.references :client, index: true
      t.references :hotel, index: true
      t.references :room, index: true

      t.timestamps null: false
    end
    add_foreign_key :orders, :clients
  end
end
