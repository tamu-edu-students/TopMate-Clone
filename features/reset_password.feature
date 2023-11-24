Feature: Password Reset
  As a user
  I want to reset my password
  So that I can regain access to my account

  

  Scenario: Reset password with valid inputs
    Given I am on "password reset" page
    When I fill in "password-field" with "ValidP@ssw0rd"
    And I fill in "password-confirmation-field" with "ValidP@ssw0rd"
    And I click the "Reset Password" button
    Then I should see "Password changed"


  Scenario: Reset password with invalid inputs
    Given I am on "password reset" page
    When I fill in "password-field" with "WeakPassword"
    And I fill in "password-confirmation-field" with "WeakPassword"
    And I click the "Reset Password" button

  Scenario: Reset password with different inputs
    Given I am on "password reset" page
    When I fill in "password-field" with "ValidP@ssw0rd1"
    And I fill in "password-confirmation-field" with "ValidP@ssw0rd2"
    Then I should see "Passwords do not match"

  Scenario: User requests password reset
    Given a user with email "test@example.com"
    And I am on forgot password page
    When the user requests to reset their password for "test@example.com"
    And I click on "Send Email" to submit a reset password form
    Then a success message should come "Email to reset password has been sent!"