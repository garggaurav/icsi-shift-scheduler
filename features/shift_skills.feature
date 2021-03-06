Feature: Users Can Add Skills To A Shift

  As an event creator,
  I want to be able to specify the skills for a shift
  So that people have a better idea of what is required to volunteer for a shift.

  Background: User and Event in Database
    Given the following users have registered for accounts:
      | email               | username | password     |
      | john_doe@uprise.com | john_doe | hellboy_new  |
    And I am on the homepage
    And I log in with username "john_doe" and password "hellboy_new"
    And the following events exist:
      | User     | Event Date | Name          | Candidate | Location |
      | john_doe | 03/03/2016 | Go Batman     | Batman    | Gotham   |
    And the following shifts exist:
      | Event     | Role     | Has Limit | Limit | Start Time | End Time | Description |
      | Go Batman | Tabling  | true      | 4     | 11:00      | 11:30    | Sit all day |
    And the following skills exist:
      | Description |
      | Blogging    |
    And the following shift skills exist:
      | Event     | Shift   | Skill    |
      | Go Batman | Tabling | Blogging |
    And I am on the page for the "Go Batman" event

    Scenario: View the skills for a shift that already exists
      Given I am on the page for the "Go Batman" event
      And I follow "Tabling"
      Then I should see "Blogging"

    Scenario: View the skills for a shift that already exists
      Given I am on the page for the "Go Batman" event
      And I follow "Tabling"
      And I follow "View Volunteers"
      Then I should not see "Blogging"
