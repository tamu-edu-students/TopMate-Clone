Feature: User Login
  As a user
  I want to log in to my account
  So that I can access my protected resources

  Scenario: Successful login
    Given I have a registered user with email "user@example.com" and password "password"
    When I visit the login page
    And I fill in "Email" with "user@example.com"
    And I fill in "Password" with "password"
    And I click the "Log in" button
    Then I should be on the home page
    And I should see "Logged in successfully!"

  Scenario: Failed login
    Given I have a registered user with email "user@example.com" and password "password"
    When I visit the login page
    And I fill in "Email" with "user@example.com"
    And I fill in "Password" with "wrong_password"
    And I click the "Log in" button
    Then I should still be on the login page
    And I should see "Invalid email or password"