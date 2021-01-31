Feature: Viewing Talent
  Background:
    Given there is a valid talent JSON containing the following users:
      | Name             | Location     | Date of Birth |
      | Homer Simpson    | Springfield  |    1956-05-12 |
      | Frank Reynolds   | Philadelphia |    1944-11-17 |
      | Diane Nguyen     | Hollywoo     |    1980-03-19 |
      | Krusty the Clown | SpringField  |    1957-10-29 |

  Scenario: User requests to see all talent
    When I request to see all the talent
    Then the platform should respond this request was successful
    And I should see "Homer Simpson"
    And I should see "Frank Reynolds"
    And I should see "Diane Nguyen"
    And I should see "Krusty the Clown"

  Scenario: User requests to see talent by location
    When I request to see all talent in "Springfield"
    Then the platform should respond this request was successful
    And I should see "Homer Simpson"
    And I should see "Krusty the Clown"
    And I should not see "Diane Nguyen"
    And I should not see "Frank Reynolds"
