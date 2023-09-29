Feature: User Login
  As a user
  I want to log in to my account
  So that I can access my protected resources

  Scenario: Successful login
    Given I have a registered user with email "user@example.com" and password "password" and first_name "user_fname" and last_name "user_lname"
    When I visit the login page
    And I fill in "email" with "user@example.com"
    And I fill in "password" with "password"
    And I click the "Login" button
    Then I should be on the dashboard page
    And I should see "Logged in successfully!"

  Scenario: Failed login on invalid password
    Given I have a registered user with email "user@example.com" and password "password" and first_name "user_fname" and last_name "user_lname"
    When I visit the login page
    And I fill in "Email" with "user@example.com"
    And I fill in "Password" with "wrong_password"
    And I click the "Login" button
    Then I should still be on the login page
    And I should see "Invalid email or password"

  Scenario: Failed login on invalid email
    Given I have a registered user with email "user@example.com" and password "password" and first_name "user_fname" and last_name "user_lname"
    When I visit the login page
    And I fill in "Email" with "wrong_user@example.com"
    And I fill in "Password" with "wrong_password"
    And I click the "Login" button
    Then I should still be on the login page
    And I should see "Invalid email or password"
