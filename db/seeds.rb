# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |i|
  Label.create!(name: "sample#{i + 1}")
end

10.times do |i|
  User.create!(id: "#{i + 1}", name: "test#{i + 1}", email: "test#{i + 1}@test#{i + 1}.com", password: "test#{i + 1}#{i + 1}#{i + 1}#{i + 1}", role: 'normal')
end

10.times do |i|
  Task.create!(title: "test#{i + 1}", details: "Test#{i + 1}", limit: "now()", status: "未着手", priority: "中", user_id: "#{i + 1}" )
end
