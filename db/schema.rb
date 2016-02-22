# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160217100217) do

  create_table "booking_periods", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "hotel_id"
    t.integer  "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "booking_periods", ["hotel_id"], name: "index_booking_periods_on_hotel_id"
  add_index "booking_periods", ["room_id"], name: "index_booking_periods_on_room_id"

  create_table "clients", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "auth_token",             default: ""
  end

  add_index "clients", ["auth_token"], name: "index_clients_on_auth_token", unique: true
  add_index "clients", ["email"], name: "index_clients_on_email", unique: true
  add_index "clients", ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true

  create_table "hotel_facilities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hotels", force: :cascade do |t|
    t.string   "name"
    t.boolean  "period_booking"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "hotels_facilities", id: false, force: :cascade do |t|
    t.integer "hotel_id"
    t.integer "hotel_facility_id"
  end

  add_index "hotels_facilities", ["hotel_facility_id", "hotel_id"], name: "index_hotels_facilities_on_hotel_facility_id_and_hotel_id"
  add_index "hotels_facilities", ["hotel_id"], name: "index_hotels_facilities_on_hotel_id"

  create_table "orders", force: :cascade do |t|
    t.string   "customer_name"
    t.string   "phone"
    t.date     "start_date"
    t.date     "end_date"
    t.decimal  "price",         precision: 6, scale: 2
    t.integer  "client_id"
    t.integer  "hotel_id"
    t.integer  "room_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "orders", ["client_id"], name: "index_orders_on_client_id"
  add_index "orders", ["hotel_id"], name: "index_orders_on_hotel_id"
  add_index "orders", ["room_id"], name: "index_orders_on_room_id"

  create_table "room_facilities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "room_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.integer  "room_type_id"
    t.integer  "hotel_id"
    t.decimal  "price",        precision: 6, scale: 2
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "rooms_facilities", id: false, force: :cascade do |t|
    t.integer "room_id"
    t.integer "room_facility_id"
  end

  add_index "rooms_facilities", ["room_facility_id", "room_id"], name: "index_rooms_facilities_on_room_facility_id_and_room_id"
  add_index "rooms_facilities", ["room_id"], name: "index_rooms_facilities_on_room_id"

end
