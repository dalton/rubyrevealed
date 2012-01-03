@http://www.pivotaltracker.com/story/show/22879771
Feature: Tagging posts
As an author
I want to be able to tag my posts
So readers can find posts on certain topics

  Scenario: Tagging a post
    Given I am an author
    When I create a post with tags
    Then the tags should be added to the tag list
    And the tags should be attached to the post

  Scenario: Finding all posts with a certain tag
    Given tagged posts
    When I select a tag
    Then I should only see posts that have that tag
