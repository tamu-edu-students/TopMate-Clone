# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# Create a User with email and password
# Create multiple users using an array
users = [
  { fname: 'user1_fname', lname: 'user1_lname', email: 'user1@example.com', password: 'password1', about: 'abcd' },
  { fname: 'user2_fname', lname: 'user1_lname', email: 'user2@example.com', password: 'password2', about: 'abcd' }
]
# User.create(users);

sessions = [{
  user_id: '8268aa66-f830-4470-b7df-bff71fdc1cb9', session_token: '5abb5ecc-5e93-11ee-8c99-0242ac120002'
}]
# ResetPasswordSession.create(sessions);

userG= [{fname:'Heisenberg', lname:'U', email:'heisenberg@gmail.com', password:'jkjk1234$',about:'student'}]
# User.create(userG);