# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create! (
  [name: 'admin', email: 'admin@admin.com',password: 'admindayo',password_confirmation: 'admindayo',role: 'admin'],
  [name: 'normal1', email: 'normal1@normal1.com',password: 'normal1',password_confirmation: 'normal1',role: 'normal'],
  [name: 'normal2', email: 'normal2@normal2.com',password: 'normal2',password_confirmation: 'normal2',role: 'normal'],
  [name: 'normal3', email: 'normal3@normal3.com',password: 'normal3',password_confirmation: 'normal3',role: 'normal'],
  [name: 'normal4', email: 'normal4@normal4.com',password: 'normal4',password_confirmation: 'normal4',role: 'normal'],
  [name: 'normal5', email: 'normal5@normal5.com',password: 'normal5',password_confirmation: 'normal5',role: 'normal'],
  [name: 'normal6', email: 'normal6@normal6.com',password: 'normal6',password_confirmation: 'normal6',role: 'normal'],
  [name: 'normal7', email: 'normal7@normal7.com',password: 'normal7',password_confirmation: 'normal7',role: 'normal'],
  [name: 'normal8', email: 'normal8@normal8.com',password: 'normal8',password_confirmation: 'normal8',role: 'normal'],
  [name: 'normal9', email: 'normal9@normal9.com',password: 'normal9',password_confirmation: 'normal9',role: 'normal'],
  [name: 'normal10', email: 'normal10@normal10.com',password: 'normal10',password_confirmation: 'normal10',role: 'normal'],
)

10.times do |i|
  Label.create!(name: "sample#{i + 1}")
end

Task.create!(
  [
    { title: 'test1', details: 'test1', limit: Time.current, priority: '中', user_id: 2},
    { title: 'test2', details: 'test2', limit: Time.current, priority: '中', user_id: 2},
    { title: 'test3', details: 'test3', limit: Time.current, priority: '中', user_id: 2},
    { title: 'test4', details: 'test4', limit: Time.current, priority: '中', user_id: 3},
    { title: 'test5', details: 'test5', limit: Time.current, priority: '中', user_id: 3},
    { title: 'test6', details: 'test6', limit: Time.current, priority: '中', user_id: 3},
    { title: 'test7', details: 'test7', limit: Time.current, priority: '中', user_id: 4},
    { title: 'test8', details: 'test8', limit: Time.current, priority: '中', user_id: 4},
    { title: 'test9', details: 'test9', limit: Time.current, priority: '中', user_id: 4},
    { title: 'test10', details: 'test10', limit: Time.current, priority: '中', user_id: 4},
  ]
)
