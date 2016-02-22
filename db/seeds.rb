# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

default_client = Client.create(email: "example@hotelsapi.com", password: "test1234", password_confirmation: "test1234")

hotels_json = ActiveSupport::JSON.decode(File.read('db/seeds/hotels.json'))

hotels_json.each do |hotel|
  Hotel.create(hotel)
end

hotel_facilities_json = ActiveSupport::JSON.decode(File.read('db/seeds/hotel_facilities.json'))

hotel_facilities_json.each do |facility|
  HotelFacility.create(facility)
end

room_facilities_json = ActiveSupport::JSON.decode(File.read('db/seeds/room_facilities.json'))

room_facilities_json.each do |facility|
  RoomFacility.create(facility)
end

room_types_json = ActiveSupport::JSON.decode(File.read('db/seeds/room_types.json'))

room_types_json.each do |facility|
  RoomType.create(facility)
end