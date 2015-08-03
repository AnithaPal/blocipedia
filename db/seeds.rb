 require 'faker'

6.times do 
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.free_email,
    password: Faker::Lorem.characters(8)
    )
  user.skip_confirmation!
  user.save!
end

  3.times do
    user = User.new(
      name:Faker::Name.name,
      email: Faker::Internet.free_email,
      password: Faker::Lorem.characters(8),
      role: 'premium_user'
      )

    user.skip_confirmation!
    user.save!

  end

  user = User.new(
    name: 'Admin',
    email: 'admin@example.com',
    password: 'helloworld',
    role: 'admin')

  user.skip_confirmation!
  user.save!

  user = User.new(
    name: 'user',
    email: 'user@example.com',
    password: 'helloworld',
    role: 'standard_user')
  user.skip_confirmation!
  user.save!

  user = User.new(
    name: 'premium',
    email: 'premium@example.com',
    password: 'helloworld',
    role: 'premium_user')
  user.skip_confirmation!
  user.save!

 users = User.all

15.times do
   Wiki.create!(
     user: users.sample,
     title:  "Public: #{Faker::Lorem.sentence}",
     body: Faker::Lorem.paragraph
   )
 end

15.times do
  Wiki.create!(
    user: users.sample,
    title: "Private: #{Faker::Lorem.sentence}",
    body: Faker::Lorem.paragraph,
    private: true
   )
 end
 puts "Seed finished"
 puts "#{User.count} users created"
 puts "#{Wiki.count} wikis created"

