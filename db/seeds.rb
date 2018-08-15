require 'faker'

pwd = 'topsecret'
cities = ["Eyl", "Raqqa", "Bordeaux", "Atlanta" ]
crews = ["The Berserker Bandits", "The Brass Knuckle Plunderers", "The Seven Sails Plunderers", "The Talking Parrot Buccaneers", "The Pillagers of the Squid", "The Pirates of the Lost Shores", "The Pirates of the North Sea", "The Thunder Waves", "The Fishguts", "The Skull and Crossbones"]
options = ["SUBMACHINE GUNS", "LIGHT MACHINE GUNS", "SNIPER RIFLE", "SHOTGUN", "PISTOL", "LAUNCHER"]
vessels = ["Black Pearl", "Jolly Roger", "Adventure Galley", "Queen Anne's Revenge", "Fancy", "Whydah", "Royal Fortune"]
img= ['https://i.pinimg.com/originals/ea/46/7f/ea467f6dc2dfdd48bfb6b57c1099d2a7.jpg', 'https://splash247.com/wp-content/uploads/2017/08/fugro-saltire.jpg', 'https://upload.wikimedia.org/wikipedia/commons/2/2f/USS_Constitution_underway%2C_August_19%2C_2012_by_Castle_Island_cropped.jpg', 'https://cloud.lovinmalta.com/images/uploads/2016/08/_blogWide/old-vessel.png?mtime=20160803085951']

10.times do
  User.create!(
    email: Faker::Internet.email,
    password: pwd,
    password_confirmation: pwd)
end
puts "Users Created"

crews.each do |name|
  date = DateTime.strptime("09/01/2009 17:00", "%m/%d/%Y %H:%M")
  Crew.create!(
    name: name,
    description: Faker::Lorem.sentence(rand(7)+5),
    availability: date,
    rating: rand(3) + 1)
end
puts "Crews Created"

options.each do |name|
  Option.create!(
    name: name,
    description: "Heavy gun's for your pleasure",
    price: (rand(10) * 50) + 250)
end
puts "Options Created"


vessels.each do |name|
  vessel = Vessel.new(
    name: name,
    description: Faker::Lorem.paragraph(5),
    category: rand(4),
    price: rand(10000),
    user: User.first,
    address: cities.sample )
  vessel.remote_photo_url = img.sample

  vessel.save!
  [3,4,5].sample.times do
    vessel.reviews.create!(
      content: Faker::Lorem.sentence(rand(7)+5),
      rating:rand(3)+1)
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
    booking.selected_options.create!(booking: booking, option: option, quantity: rand(3))
  end
  booking.crew = Crew.find(rand(Crew.count) + 1)
end
puts "Bookings Created with SelectedOptions & Crews"
