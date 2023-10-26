# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# Create a User with email and password
# Create multiple users using an array

users = [{
  fname: 'John', lname: 'Doe', email: 'johndoe@gmail.com', password: 'password', username: 'johndoe', profile_image:'', about: 'This is John Doe. He is a great guy. He is a great guy. He is a great guy. He is a great guy. He is a great guy. He is a great guy. He is a great guy. He is a great guy. He is a great guy. He is a great guy. He is a great guy. He is a great guy. He is a great guy.',
}]
User.create(users)

services = [{
  user_id: User.find_by(fname: 'John').id, name: 'Service 1', price: 10.00, duration: 30, is_published: true, description: 'This is a service'
}, {
  user_id: User.find_by(fname: 'John').id, name: 'Service 2', price: 20.00, duration: 60, is_published: false, description: 'This is another service'
}, {
  user_id: User.find_by(fname: 'John').id, name: 'Service 3', price: 20.00, duration: 60, is_published: true, description: 'This is another service'
}, {
  user_id: User.find_by(fname: 'John').id, name: 'Service 4', price: 20.00, duration: 60, is_published: false, description: 'This is another service'
}]
Service.create(services)

appts = [{
    service_id: Service.find_by(name: 'Service 1').id,
    user_id: User.find_by(fname: 'John').id,
    fname: "Test",
    lname: "User",
    email: "Testuser@gmail.com",
    startdatetime: DateTime.parse('2023-10-22T14:30:00'),
    enddatetime: DateTime.parse('2023-10-22T16:30:00'),
    amount_paid: 123,
    status: "Scheduled",
    created_at: DateTime.parse('2023-10-24T14:30:00'),
    updated_at: DateTime.parse('2023-10-24T14:30:00')
  }]

Appointment.create(appts)

# ResetPasswordSession.create(sessions);

[{ fname: 'Heisenberg', lname: 'U', email: 'heisenberg@gmail.com', password: 'jkjk1234$', about: 'student' }]
# User.create(userG);
