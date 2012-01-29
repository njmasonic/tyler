Feature: SSO Sign in

  In order to authenticate a user via Tyler
  As a consumer website
  I want the user to sign in

  Background:
    Given the consumer "lodge00" is enabled
    And the consumer "lodge01" is enabled
    And I am signed up as "tom@smith.net"

  @mechanize
  Scenario: A user signs in through another website
    When I sign in as "tom@smith.net" through consumer "lodge00"
    Then I should be redirected to the "lodge00" consumer
    And I should have a valid token for "tom@smith.net"

  @mechanize
  Scenario: A user who has already signed in is immediately redirected
    When I sign in as "tom@smith.net" through consumer "lodge00"
    And consumer "lodge01" sends me to the sign in page
    Then I should be redirected to the "lodge01" consumer
    And I should have a valid token for "tom@smith.net"
