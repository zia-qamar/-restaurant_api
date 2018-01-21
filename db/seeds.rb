# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
5.times do |index|
  Guest.create(name: "Zia #{index}", email: "zia.qamar_#{index}@gmail.com")
  Hotel.create(name: "Hotel #{index}", email: "hotel.qamar_#{index}@gmail.com", phone: '987987', start_time: '9am', end_time: '10pm')
end