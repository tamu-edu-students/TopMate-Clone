Feature: Edit the public page

  Scenario: User edits the public page 
    Given I am on the edit the public page
    When I update my "Lname" to "Wick"
    And I submit the update form by clicking on "Update User Public Profile"
    Then I should see information "Wick" on the public page
