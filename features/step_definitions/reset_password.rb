# frozen_string_literal: true

Given('I am on {string} page') do |_page|
  user = User.create(email: 'userfortestingreset@gmail.com', password: 'jkjk1234$', fname: 'Test', lname: 'user',
                     id: '8268aa66-f830-4470-b7df-bff71fdc1cb9')
  user.save!
  session = ResetPasswordSession.create(user_id: '8268aa66-f830-4470-b7df-bff71fdc1cb9',
                                        session_token: '5abb5ecc-5e93-11ee-8c99-0242ac120002')
  session.save!
  visit '/password_reset_edit_url/5abb5ecc-5e93-11ee-8c99-0242ac120002'
end
