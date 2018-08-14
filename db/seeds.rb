# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
pwd = 'topsecret'

User.create!(email: Faker::Internet.email, password: pwd, password_confirmation: pwd)

9.times do
  User.create!(email: Faker::Internet.email, password: pwd, password_confirmation: pwd)
end
puts "Users Created"

["The Berserker Bandits", "The Brass Knuckle Plunderers", "The Seven Sails Plunderers", "The Talking Parrot Buccaneers", "The Pillagers of the Squid", "The Pirates of the Lost Shores", "The Pirates of the North Sea", "The Thunder Waves", "The Fishguts", "The Skull and Crossbones"].each do |name|
  date = DateTime.strptime("09/01/2009 17:00", "%m/%d/%Y %H:%M")
  Crew.create!(name: name, description: Faker::Lorem.sentence(rand(7)+5), availability: date, rating: rand(3) + 1)
end
puts "Crews Created"

["SUBMACHINE GUNS", "LIGHT MACHINE GUNS", "SNIPER RIFLE", "SHOTGUN", "PISTOL", "LAUNCHER"].each do |name|
  Option.create!(name: name, description: "Heavy gun's for your pleasure", price: (rand(10) * 50) + 250)
end
puts "Options Created"

["Black Pearl", "Jolly Roger", "Adventure Galley", "Queen Anne's Revenge", "Fancy", "Whydah", "Royal Fortune"].each do |name|
  vessel = Vessel.new(name: name, description: Faker::Lorem.paragraph(5), price: rand(10000), user: User.first, lat: Faker::Address.latitude, lng: Faker::Address.longitude )
  vessel.remote_photo_url = 'https://i.pinimg.com/originals/ea/46/7f/ea467f6dc2dfdd48bfb6b57c1099d2a7.jpg'
  vessel.save!
  [3,4,5].sample.times do
    vessel.reviews.create!(content: Faker::Lorem.sentence(rand(7)+5) ,rating:rand(3)+1)
  end
end
puts "Vessels Created with Reviews"

Vessel.all.each do |vessel|
  (rand(3) + 2).times do
    VesselOption.create!(vessel: vessel, option: Option.find(rand(Option.count) + 1))
  end
end
puts "VesselOptions Created"

3.times do
  user = User.find(rand(User.count) + 1)
  vessel = Vessel.find(rand(Vessel.count) + 1)
  date = DateTime.strptime("09/01/2009 17:00", "%m/%d/%Y %H:%M")
  booking = Booking.create!(user: user, vessel: vessel, start_date: date , end_date: date, status: "pending")
  vessel.options.each do |option|
    SelectedOption.create!(booking: booking, option: option, quantity: rand(3))
  end
  booking.crew = Crew.find(rand(Crew.count) + 1)
end
puts "Bookings Created with SelectedOptions & Crews"
