Feature: Using posts

  Scenario: Interacting with posts
    Given I am on the posts page
    Then The list of posts is empty

    When I create a new post
    Then I should see the post details

    When I am on the posts page
    Then I see the latest post in the list

    When I delete the latest post
    Then The list of posts is empty

  Scenario: Commenting on a post
    Given There is an existing post
    And I am on the latest post page
    And I create a comment
    Then I can see the comment

    When I delete the comment
    Then I can not see any comments
