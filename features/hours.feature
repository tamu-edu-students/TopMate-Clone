Feature: Available Hours
  As an admin,
  So that people can see my availability,
  I want to be able to set my hours in the dashboard.

  Scenario: I see can go to the hours page and see Sat-Sun listed
    Given I am on the hours page
    Then I should see "Saturday"
    And  I should see "Monday"
    And  I should see "Tuesday"
    And  I should see "Wednesday"
    And  I should see "Thursday"
    And  I should see "Friday"
    And  I should see "Saturday"

  Scenario: I should be able to add an availability period
    Given I am on the add hours page
    And I fill in time select "Start time" with "9:15 PM"
    And I fill in time select "End time" with "11:00 PM"
    When I click on "Create Availability"
    Then I should be on the hours page
    And I should see "9:15pm - 11:00pm"
  
  Scenario: I should not be able to set an end time before start time
    Given I am on the add hours page
    And I fill in time select "Start time" with "11:00 PM"
    And I fill in time select "End time" with "10:15 PM"
    When I click on "Create Availability"
    Then I should see "failed"
