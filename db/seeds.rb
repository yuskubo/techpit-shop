User.create!(name: 'TestUser', email: 'test@example.com')
14.times do |n|
  name = Faker::Name.name
  email = "test-#{n+1}@example.com"
  User.create!(name: name, email: email)
end
