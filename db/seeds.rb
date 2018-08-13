# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

10.times do
  pwd = Faker::Lorem.characters(10)
  User.create!(email: Faker::Internet.email, password: pwd, password_confirmation:pwd)
end
puts "Users Created"


["SUBMACHINE GUNS", "LIGHT MACHINE GUNS", "SNIPER RIFLE", "SHOTGUN", "PISTOL", "LAUNCHER"].each do |name|
  Option.create!(name: name, description: "Heavy gun's for your pleasure", price: (rand(10)*50)+250 )
end
puts "Options Created"

["Black Pearl", "Jolly Roger", "Adventure Galley", "Queen Anne's Revenge", "Fancy", "Whydah", "Royal Fortune"].each do |name|
  Vessel.create(name: name, description:Faker::Lorem.paragraph(5), price: rand(10000), user: User.find(rand(User.count)))
end
puts "Vessels Created"
