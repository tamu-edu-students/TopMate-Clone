Feature: Delete Service
    As an admin,
    So that I can delete a service,
    I would like to be able to delete a service displayed in the dashboard

  Scenario: delete an existing service
    Given I am on the services index page
    When I click "Delete" button for "service 123"
    Then I should see a success message confirming the deletion 
    And "service 123" should'nt be there in the services index page 