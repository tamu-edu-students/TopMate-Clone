Feature: Users can view a service from the public page

  Scenario: I can view a service
    Given I am on the user's public page
    When I click on "Service 1" link
    Then I should see "Back to"
    And I should see "Purchase"