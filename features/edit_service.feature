Feature: Edit Service
    As an admin,
    So that I can edit the information displayed on a service,
    I would like to be able to edit a services information in the dashboard

  

  Scenario: Edit an existing service
    Given I am on "edit service" page for an existing service
    When I fill in "service_name" with "Mock Sessions"
    And I fill in "service_description" with "Mock sessions for 40 hrs"
    And I fill in "service_price" with "777"
    And I fill in "service_duration" with "776"
    And I click the "Edit Service" button
    Then I should see "Mock Sessions"
    Then I should see "Mock sessions for 40 hrs"
    Then I should see "777"
    Then I should see "776"



 
  Scenario: Edit an invalid service
    Given I am on "edit service" page for an invalid service
    Then I should see "Service does not exist."