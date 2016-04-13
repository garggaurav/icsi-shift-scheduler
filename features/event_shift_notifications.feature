Feature: Users will receive timely notifications for events and shifts

  As an event creator and/or a volunteer,
  I want to be notified when I have an event or a shift coming up,
  So that I am more likely to show up

  Background: User, Event, Shift, UserActivities, and ActivityTypes in Database
    Given the following users have registered for accounts:
      | email               | username | password     |
      | john_doe@uprise.com | john_doe | hellboy_new  |
    And I am on the homepage
    And I log in with username "john_doe" and password "hellboy_new"
    And the following events exist:
      | User | Event Date | Name         | Candidate   | Location |
      | 1    | 04/8/2017  | Go Batman    | Batman      | Gotham   |
      | 1    | 05/8/2017  | Go Harvey    | Harvey Dent | Gotham   |
    And the following shifts exist:
      | Event | Role     | Has Limit | Limit | Start Time | End Time | Description   |
      | 1     | Tabling  | true      | 4     | 11:00 am   | 11:30 am | Sit all day   |
      | 1     | Flyering | true      | 1     | 10:30 pm   | 11:30 pm | Stand all day |
    # And the following volunteer commitments exist:
    #   | User     | Event     | Shift    |
    #   | john_doe | Go Batman | Tabling  |
    #   | john_doe | Go Batman | Flyering |
    And the following activity_types exist:
      | Activity                    |
      | User has joined shift:      |
      | User has left shift:        |
      | Shift is full:              |
      | You have an event tomorrow: |
      | You have a shift tomorrow:  |
    
  Scenario: Receive event notification 24 hours before a shift
    Given I am on the page for the "Tabling" shift for the "Go Batman" event
    When I follow "Join"
    Given I am on the user activity page
    Then I should see "You have a shift tomorrow: Tabling"

  Scenario: Receive shift notification 24 hours before an event
    Given I am on the home page
    When I follow "Create Event"
    When I fill in "Event Name" with "Go Harvey"
    And I fill in "Location" with "Gotham"
    And I select "03/03/2020" as the "Event Date"
    And I fill in "Candidate" with "Harvey Dent"
    And I fill in "Description" with "A fundraiser for Harvey"
    And I press "Create Event"
    When I am on the user activity page
    Then I should see "You have an event tomorrow: Go Harvey"

  Scenario: No notification for shifts more than 24 hours away
    Given I am on the user activity page
    And I should not see "You have a shift tomorrow: Stand all day"
    
  Scenario: No notification for events more than 24 hours away
    Given I am on the user activity page
    And I should not see "You have an event tomorrow: Go Harvey"
    