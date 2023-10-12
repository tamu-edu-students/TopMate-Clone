require 'rails_helper'

RSpec.feature 'Services', type: :feature do
  let(:user) { create(:user) }

  scenario 'User creates a new service' do
    # Log in the user (assuming you have authentication set up)
    login_as(user, scope: :user)

    # Visit the index page
    visit services_path

    # Click on the "New Service" button
    click_link 'New Service'

    # Fill in the form with service details
    fill_in 'Name', with: 'New Service'
    # Fill in other fields as needed

    # Submit the form
    click_button 'Create Service'

    # Expectations
    expect(page).to have_text('Service created successfully.')
    expect(page).to have_text('New Service')

    # Additional expectations as needed
  end
end