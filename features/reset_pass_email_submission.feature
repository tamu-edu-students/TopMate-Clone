Feature: Reset Password Email Submission
    Page to submit email to receive link for resetting you password

    Scenario Outline: Email is valid or invalid
        Given I am on the "email submission" page
        When I type a "<emailtype>" email
        And I click the Send Email button
        Then I am told "<message>"
        
    Examples:
    | emailtype     | message                                    |
    | unassociated  | This email is not associated with any user |
    | valid         | Email to reset password has been sent!     |

    Scenario: Reset Session Generated
        Given I am on the "email submission" page
        When I type a "valid" email
        And I click the Send Email button
        Then a reset session is generated

    Scenario: Redirected to Login Page
        Given I am on the "email submission" page
        When I click the return to login link
        Then I am redirected to the login page