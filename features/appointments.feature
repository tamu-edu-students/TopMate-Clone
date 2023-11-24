Feature: Appointment Creation
  As a customer
  I want to book a new appointment
  So that I can schedule a service with the admin at a convenient date and time.

  Scenario: Invalid Username
    Given I have a registered user with email "john@example.com" and password "password" and first_name "John" and last_name "Doe" and username "johndoe"
    When I go to appointment page for one service of "johndoe123" to book appointment
    Then I should redirected back to public page

  Scenario: Incomplete Appointment Form
    Given I am on public page of "Jack" for booking the appointment
    When I click on "Service 1" to open service page
    Then I clck on "Purchase" to go the appointment page
    And I should be on the "Service 1" booking appointment page of "Jack"
    And I click the "Create Appointment" button to create appointment
    Then I should see a error message "Please enter your First Name, Last Name, Email, Appointment Date, Consultation Start Time"

    Scenario: Edit Appoinment Data
    Given I have created a appointment and now i want to update the data
    When I visit the edit appointment page
    Then I change my "Appointment Date" with available time on 2 day from today
    When I click the "Update Appointment" button to update appointment data
    Then I should redirected back to public page 
    And The appointment should be updated with available time on 2 day from today in database
    And I should see a success message "Appointment updated successfully!"
