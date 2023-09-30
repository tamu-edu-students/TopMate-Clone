Feature: Password Reset
  As a user
  I want to reset my password
  So that I can regain access to my account

  Background:
    Given I am on the password reset page

  Scenario: Reset password with valid inputs
    When I fill in "password-field" with "ValidP@ssw0rd"
    And I fill in "password-confirmation-field" with "ValidP@ssw0rd"
    And I submit the form
    Then I should see "Password successfully reset."

  Scenario: Reset password with invalid inputs
    When I fill in "password-field" with "WeakPassword"
    And I fill in "password-confirmation-field" with "WeakPassword"
    And I submit the form
    Then I should see "Password does not meet all criteria"
