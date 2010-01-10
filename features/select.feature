Feature: Select

  Scenario: Selects supporting multiple selected elements can be identified
    When I am on the "multiple select" page
    And I find the select with name "not-multiple"
    Then the select should not be a multiple select
    When I find the select with name "multiple"
    Then the select should be a multiple select

  Scenario: Child options can be retrieved
    When I am on the "basic select" page
    And I find the select with name "basic-select"
    Then I should be able to get all options
    And the "first" option should have value "1" and text "one"
    And the "second" option should have value "2" and text "two"

  Scenario: Selected options can be retrieved
    When I am on the "selected options" page
    And I find the select with name "selected-options"
    Then the selected options should include the option with value "1"
    And the selected options should include the option with value "2"
    And the selected options should not include the option with value "3"

  Scenario: The first selected option can be retrieved
    When I am on the "selected options" page
    And I find the select with name "selected-options"
    Then the first selected option should have the value "1"

  @wip
  Scenario: Selecting options
    When I am on the "selecting options" page
    And I find the select with name "selecting-options"
    And I select by the text the option with visible text "One"
    And I select by index the "second" option
    And I select by value the option with value "3"
    Then the "first" option should be selected
    And the "second" option should be selected
    And the "third" option should be selected
