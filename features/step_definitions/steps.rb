class String
  def as_number()
    case self
      when 'first'
        0
      when 'second'
        1
      else
        raise "Uknown position #{self}"
    end
  end
end

When /^I am on the "([^\"]*)" page$/ do |page_name|
  pages_url_for = Pages.url_for(page_name)
  puts pages_url_for
  @driver.navigate.to( pages_url_for)
end

When /^I find the select with name "([^\"]*)"$/ do |select_name|
  @select = Select.new(@driver.find_element(:name, select_name))
end

Then /^the select should not be a multiple select$/ do
  @select.multiple?.should be_false
end

Then /^the select should be a multiple select$/ do
  @select.multiple?.should be_true
end

Then /^I should be able to get all options$/ do
  @options = @select.options
end

When /^the "([^\"]*)" option should have value "([^\"]*)" and text "([^\"]*)"$/ do |position, expected_value, expected_text|
  @options[position.as_number].value.should == expected_value
end

Then /^the selected options should include the option with value "([^\"]*)"$/ do |expected_value|
  expected_element_found = @select.selected_options.select { |option| option.value == expected_value }.length == 1

  if !expected_element_found
    raise "No selected element with value #{expected_value} found."
  end
end
Then /^the selected options should not include the option with value "([^\"]*)"$/ do |unexpected_value|
  element_found = @select.selected_options.select { |option| option.value == unexpected_value }.length == 1

  if element_found
    raise "Unexpected selected element with value #{unexpected_value} found."
  end
end

Then /^the first selected option should have the value "([^\"]*)"$/ do |expected_value|
  @select.first_selected_option.value.should == expected_value
end

When /^I select by the text the option with visible text "([^\"]*)"$/ do |text|
  @select.select_by_visible_text(text)
end

When /^I select by index the "([^\"]*)" option$/ do |index|
  @select.select_by_index(index)
end

When /^I select by value the option with value "([^\"]*)"$/ do |value|
  @select.select_by_value(value)
end

Then /^the "([^\"]*)" option should be selected$/ do |position|
  @select.options[position.as_number].selected?.should be_true
end