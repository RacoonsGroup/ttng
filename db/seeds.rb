# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create!(first_name: 'Admin', last_name: 'Admin', email: 'admin@example.com', password: 'password', password_confirmation: 'password', position: 'admin')
User.create!(first_name: 'Developer', last_name: 'Developer', email: 'developer@example.com', password: 'password', password_confirmation: 'password', position: 'developer')

User.create!(first_name: 'Manager', last_name: 'Manager', email: 'manager@example.com', password: 'password', password_confirmation: 'password', position: 'manager')