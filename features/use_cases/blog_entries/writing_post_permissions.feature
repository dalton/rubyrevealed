@http://www.pivotaltracker.com/story/show/22819939
Feature: Writing post permissions
  As an author
  I want to be able to sign in
  So I can write posts for others to read


  Scenario: Author writes a post
    Given I am an author
    When I write a post
    Then everyone can read the post

  Scenario: Guest cannot write a post
    Given I am a guest
    When I view the blog
    Then I should not be able to write a post
