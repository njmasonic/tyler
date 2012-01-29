Feature: Authorization API

  In order to allow users to sign up
  As an API service
  I want to update registration information

  Background:
    Given the api key "abc123" is enabled
    And the following attributes are required for registration:
      | code      |
      | last_name |
      | zip_code  |

  @mechanize
  Scenario: Creating an authorization allows a user to register
    When I use the api key "abc123" to create the authorization:
      | code         | 1234  |
      | last_name    | Smith |
      | zip_code     | 10001 |
      | access_level | 42    |
    Then I can sign up "tom@smith.net" using:
      | code         | 1234  |
      | last_name    | Smith |
      | zip_code     | 10001 |
