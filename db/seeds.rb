20.times do
  User.create(email: Faker::Superhero.name, password: "123")
end
