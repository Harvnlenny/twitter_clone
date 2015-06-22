# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
30.times do
  u = User.new
  u.name = Faker::Name.name
  u.username = Faker::Internet.user_name
  u.email = Faker::Internet.email(u.name)
  u.password = Faker::Internet.password(8)
  u.password_confirmation = u.password
  u.avatar = Faker::Avatar.image
  u.save
end

30.times do
  p = Post.new
  p.user_id = Random.rand(1..User.count)
  p.body = Faker::Hacker.say_something_smart
  p.save
end