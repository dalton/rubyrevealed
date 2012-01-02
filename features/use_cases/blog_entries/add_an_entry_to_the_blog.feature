Feature: Add an entry
  As an author
  I want to create entries
  So people can read what's on my mind

  Scenario: First Post
    Given I am an author
    When I write a post
    Then I should see the post
