Feature: Public Page available to users

  Scenario: User navigates to the valid public page
    Given The user exists
    When I navigate to the public page
    Then I should see the "public" page

  Scenario: User navigates to the invalid public page
    Given The user does not exist
    When I navigate to the public page
    Then I should see the "user not found" page

  Scenario: Services are displayed on the public page
    Given The user exists
    When I navigate to the public page
    Then I should see the users services