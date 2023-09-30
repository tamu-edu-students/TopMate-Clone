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
    Then I should see "Password does not meet all criteria"
