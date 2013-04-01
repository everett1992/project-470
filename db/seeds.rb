# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do |i|
  owner = User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "owner_#{i}@example.com",
    password: 'test'
  )
  dwelling = Dwelling.create(name: Faker::Address.street_address, owner: owner)
  owner.dwelling = dwelling
  owner.save
  4.times do |j|
    user = User.create(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: "user_#{i}_#{j}@example.com",
      password: 'test'
    )
    user.dwelling = dwelling
    user.save
  end
  ['Rent','Food'].each do |k|
    bill = Bill.create(
      name: k,
      # Faker::Company.name introduced some weird behaviour (generated < 20 bills)!  Just going to use people names.
      #owed_to: Faker::Company.name, 
      owed_to: Faker::Name.first_name,
      amount: 800.55 + rand(500),
      date_due: Date.today.next_month,
      status: 'unpaid'
    )
    bill.dwelling = dwelling
    bill.save
  end                  
end

puts "Created #{User.count} Users"
puts "Created #{Dwelling.count} Dwellings"
puts "Created #{Bill.count} Bills"
