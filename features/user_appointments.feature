Feature: Appointment page for admin

  Scenario: User views appointments from the dashboard
    Given I have multiple appointments listed under me
    When I visit the dashboard page
    And I click on "Appointments" button
    Then I should see a list of all my appointments
    And each appointment should display its details

 