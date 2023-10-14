Feature: Reset Password Email Submission
    Page to submit email to receive link for resetting you password

    Scenario Outline: Email is valid
        Given I am on the "email submission" page
        When I type a "valid" email
        And I click the Send Email button
        Then I am told "Email to reset password has been sent!"

    Scenario Outline: Email is invalid
        Given I am on the "email submission" page
        When I type a "unassociated" email
        And I click the Send Email button
        Then I am told "This email is not associated with any user"

    Scenario: Reset Session Generated
        Given I am on the "email submission" page
        When I type a "valid" email
        And I click the Send Email button
        Then a reset session is generated

    Scenario: Redirected to Login Page
        Given I am on the "email submission" page
        When I click the return to login link
        Then I am redirected to the login page