module ResetPassEmailSubmissionStepHelper
  def get_email(emailtype)
    if emailtype == 'unassociated'
      'unassociated@gmail.com'
    elsif emailtype == 'valid'
      User.create!(id: 123, email: 'user1@example.com', password: 'password')
      'user1@example.com'
    end
  end
end
World ResetPassEmailSubmissionStepHelper

Given("I am on the {string} page") do |page|
  visit '/submitemail'
end

Then("I am told {string}") do |expected|
  expect(page).to have_content(expected)
end

When("I type a {string} email") do |emailtype|
  fill_in 'Email Address', with: get_email(emailtype)
end

When("I click the Send Email button") do
  click_button 'Send Email'
end

When("I click the return to login link") do
  click_link 'Return to Login'
end

Then("I am redirected to the login page") do
  expect(page).to have_current_path('/')
end

Then("a reset session is generated") do
  expect(ResetPasswordSession.count).to eq(1)
end