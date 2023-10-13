Feature: Service Dashboard and Adding New Service

  Scenario: User views services from the dashboard
    Given I have multiple services listed under me
    When I visit the dashboard page
    And I click on the "Services" button
    Then I should see a list of all my services
    And each service should display its details

  Scenario: User adds a new service
    Given I am on the services page
    When I click "Create New Service"
    And I fill in the required service details  
    And I submit the form by clicking on "Create Service"
    Then the new service should be added to my services
    And I should see a success message confirming the addition