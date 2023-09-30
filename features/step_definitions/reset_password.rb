# # require 'rails_helper'

# RSpec.feature 'Password Reset', type: :feature, js: true do
#   scenario 'User resets password with valid inputs' do
#     visit '/password_reset' # Adjust the path as needed

#     # Fill in form fields
#     fill_in 'password-field', with: 'ValidP@ssw0rd'
#     fill_in 'password-confirmation-field', with: 'ValidP@ssw0rd'

#     # Submit the form
#     click_button 'Reset Password'

#     # Add expectations based on the expected behavior after a successful password reset
#     expect(page).to have_text('Password successfully reset.')
#   end

#   scenario 'User resets password with invalid inputs' do
#     visit '/password_reset' # Adjust the path as needed

#     # Fill in form fields with invalid inputs
#     fill_in 'password-field', with: 'WeakPassword'
#     fill_in 'password-confirmation-field', with: 'WeakPassword'

#     # Submit the form
#     click_button 'Reset Password'

#     # Add expectations based on the expected behavior after an invalid password reset attempt
#     expect(page).to have_text('Password does not meet all criteria')
#   end
# end
