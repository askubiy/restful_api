# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

hotels_json = ActiveSupport::JSON.decode(File.read('db/seeds/hotels.json'))

hotels_json.each do |hotel|
  Hotel.create(hotel)
end