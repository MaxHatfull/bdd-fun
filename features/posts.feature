Feature: Using posts

  Scenario: Interacting with posts
    Given I am on the posts page
    Then I should see a posts title
    And I should see a new post button
    And The list of posts is empty

    When I create a new post
    Then I should see the post details

    When I go back to the posts page
    Then I see the latest post in the list

    When I delete the latest post
    Then The list of posts is empty
