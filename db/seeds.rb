# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

users = [
    { name: 'user1', email: 'user1@example.com', password: 'password1', about: 'abcd' },
    { name: 'user2', email: 'user2@example.com', password: 'password2', about: 'abcd' }
  ]
  User.create(users)