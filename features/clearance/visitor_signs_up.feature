Feature: Sign up

  In order to access protected sections of the site
  As a visitor
  I want to sign up

  Background:
    Given there are no configured registration properties
    And the authorization code "1234" is valid and unused

  Scenario: Visitor signs up with invalid email
    When I sign up with "invalidemail" and "password" using code "1234"
    Then I am told to enter a valid email address

  Scenario: Visitor signs up with blank password
    When I sign up with "email@example.com" and "" using code "1234"
    Then I am told to enter a password

  Scenario: Visitor signs up with valid data
    When I sign up with "email@example.com" and "password" using code "1234"
    Then I should be signed in
