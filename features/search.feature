Feature: Search my web blog
  In order to keep my blog accessible
  As author of blog posts.
  I want to be sure that I am visible in google.

  Scenario: Search my blog by my full name
    Given I use docs fixture "couchapp.json"
    Given I am on the homepage
    And stay on the page

