Feature: Appointment Creation
  As a customer
  I want to book a new appointment
  So that I can schedule a service with the admin at a convenient date and time.

  @javascript
  Scenario: Successful Appointment
    Given I am on public page of "John" for booking the appointment
    When I click on "Book an Appointment" for "Service 1"
    Then I should be on the  "Service 1" booking appointment page of "Jack"
    And I fill in customer "First Name" with "Moorie"
    And I fill in customer "Last Name" with "Edrick"
    And I fill in customer "Email" with "user@example.com"
    And I fill in customer "Appointment Date" with first available start date
    And I fill in customer "Consultation Start Time" with first available start time
    And I click the "Create Appointment" button
    Then I should redirected back to public page of "Jack" 
    And I should see a success message "Appoinment Created successfully"

 
