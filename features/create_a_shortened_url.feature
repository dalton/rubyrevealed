@http://www.pivotaltracker.com/story/show/23457837 @shortener
Feature: Create a shortened url


  @wip
  Scenario: When a post is created, a short url is automatically assigned to it
    Given I am an author
    When I write a post
    When I view the post
    Then the permalink should be a short url
