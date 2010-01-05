require 'spec'
require 'spec/spec_helper'

describe Select do
  it "should throw an exception if the element is not a select element" do
    an_anchor = mock(:an_anchor)
    an_anchor.should_receive(:tag_name).and_return('a')
    running { Select.new(an_anchor)}.should raise_error UnexpectedTagNameError

    a_select = mock(:an_anchor)
    a_select.should_receive(:tag_name).and_return('select')
    running { Select.new(a_select)}.should_not raise_error

  end

  it "should indicate that a select can support multiple options" do
    a_multiple_select = mock(:select)
    a_multiple_select.stub(:tag_name).and_return('select')
    a_multiple_select.should_receive(:attribute).with('multiple').and_return('multiple')

    select = Select.new(a_select)
    select.multiple?.should be_true
  end

  it "should not indicate that a normal select supports multiple options" do
    a_normal_select = mock(:select)
    a_normal_select .stub(:tag_name).and_return('select')
    a_normal_select.should_receive(:attribute).with('multiple').and_throw(Selenium::WebDriver::Error::WebDriverError.new)

    select = Select.new(a_normal_select)
    select.multiple?.should be_false
  end
end