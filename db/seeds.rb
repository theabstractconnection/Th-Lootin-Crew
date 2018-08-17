require 'faker'

pwd = 'topsecret'
cities = ["Kabul", "Tirana", "Algiers", "Andorra la Vella", "Luanda", "Saint John's", "Buenos Aires", "Yerevan", "Canberra", "Vienna", "Baku", "Nassau", "Manama", "Dhaka", "Bridgetown", "Minsk", "Brussels", "Belmopan", "Porto-Novo", "Thimphu", "La Paz", "Sarajevo", "Gaborone", "Brasilia", "Bandar Seri Begawan", "Sofia", "Ouagadougou", "Bujumbura", "Phnom Penh", "Yaounde", "Ottawa", "Praia", "Bangui", "N'Djamena", "Santiago", "Beijing", "Bogota", "Moroni", "Brazzaville", "Kinshasa", "San Jose", "Yamoussoukro", "Zagreb", "Havana", "Nicosia", "Prague", "Copenhagen", "Djibouti", "Roseau", "Santo Domingo", "Dili", "Quito", "Cairo", "San Salvador", "Malabo", "Asmara", "Tallinn", "Addis Ababa", "Suva", "Helsinki", "Paris", "Libreville", "Banjul", "Tbilisi", "Berlin", "Accra", "Athens", "Saint George's", "Guatemala City", "Conakry", "Bissau", "Georgetown", "Port-au-Prince", "Tegucigalpa", "Budapest", "Reykjavik", "New Delhi", "Jakarta", "Tehran", "Baghdad", "Dublin", "Jerusalem", "Rome", "Kingston", "Tokyo", "Amman", "Astana", "Nairobi", "Tarawa Atoll", "Pyongyang", "Seoul", "Pristina", "Kuwait City", "Bishkek", "Vientiane", "Riga", "Beirut", "Maseru", "Monrovia", "Tripoli", "Vaduz", "Vilnius", "Luxembourg", "Skopje", "Antananarivo", "Lilongwe", "Kuala Lumpur", "Male", "Bamako", "Valletta", "- Majuro", "Nouakchott", "Port Louis", "Mexico City", "Palikir", "Chisinau", "Monaco", "Ulaanbaatar", "Podgorica", "Rabat", "Maputo", "Rangoon", "Windhoek", "Kathmandu", "Amsterdam", "Wellington", "Managua", "Niamey", "Abuja", "Oslo", "Muscat", "Islamabad", "Melekeok", "Panama City", "Port Moresby", "Asuncion", "Lima", "Manila", "Warsaw", "Lisbon", "Doha", "Bucharest", "Moscow", "Kigali", "Basseterre", "Castries", "Kingstown", "Apia", "San Marino", "Sao Tome", "Riyadh", "Dakar", "Belgrade", "Victoria", "Freetown", "Singapore", "Bratislava", "Ljubljana", "Honiara", "Mogadishu", "Pretoria", "Juba ", "Madrid", "Colombo", "Khartoum", "Paramaribo", "Mbabane", "Stockholm", "Bern", "Damascus", "Taipei", "Dushanbe", "Dar es Salaam", "Bangkok", "Lome", "Nuku'alofa", "Port-of-Spain", "Tunis", "Ankara", "Ashgabat", "Vaiaku village, Funafuti province", "Kampala", "Kyiv", "Abu Dhabi", "London", "Washington D.C.", "Montevideo", "Tashkent", "Port-Vila", "Vatican City", "Caracas", "Hanoi", "Sanaa", "Lusaka", "Harare"]
crews = ["The Berserker Bandits", "The Brass Knuckle Plunderers", "The Seven Sails Plunderers", "The Talking Parrot Buccaneers", "The Pillagers of the Squid", "The Pirates of the Lost Shores", "The Pirates of the North Sea", "The Thunder Waves", "The Fishguts", "The Skull and Crossbones"]
options = ["SUBMACHINE GUNS", "LIGHT MACHINE GUNS", "SNIPER RIFLE", "SHOTGUN", "PISTOL", "LAUNCHER", "SPACE RAY GUN", "DEATH DRONE"]
options= options.map { |opt| opt.capitalize}
vessels = ["Black Pearl", "Jolly Roger", "Adventure Galley", "Queen Anne's Revenge", "Fancy", "Whydah", "Royal Fortune", "The Death of Princess", "The Captains Terror", "The Sadness of the Killer", "The Murderous Caribbean", "The Drunken Tide", "The Curse of the Curse", "The Privateers Lightning", "The Rising Damnation", "The Deceit of Lust", "The Horrid Galley", "The Impolite James","The Poisoned Trinity","The Homicidal North","The Manta","The Davy Jones King","The Pirates Hangman","The Sadness of the Galley","The Lust","The Angry Pillager","The Murderers Saber"]



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
    price: rand(1000),
    user: User.first,
    address: cities.sample )
  vessel.remote_photo_url = Faker::LoremFlickr.image("800x600", ['vessel'])

  vessel.save!
  [3,4,5].sample.times do
    vessel.reviews.create!(
      content: Faker::Lorem.sentence(rand(7)+5),
      rating:rand(3)+1)
  end
end
puts "Vessels Created with Reviews"

Vessel.all.each_with_index do |vessel|
  i = (1..(Option.count)).to_a.shuffle
  p i
  (0..(rand(3)+1)).each_with_index do |v, index|
    puts i[index]
    VesselOption.create!(vessel: vessel, option: Option.find(i[index]))
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
