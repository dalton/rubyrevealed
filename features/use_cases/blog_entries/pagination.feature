@http://www.pivotaltracker.com/story/show/22918021
Feature: Pagination

  Scenario: More than 10 posts in the blog
    Given there are 40 posts in the blog
    When I read the blog
    Then I should see the 10 most recent posts
    And I should be able to get to older posts

  Scenario: 10 or fewer posts
    Given there are 9 posts in the blog
    When I read the blog
    Then I should see the 9 most recent posts
    And I should not be able to navigate to older posts
