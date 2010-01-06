require 'spec'
require 'spec_helper'

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

    select = Select.new(a_multiple_select)
    select.multiple?.should be_true
  end

  it "should not indicate that a normal select supports multiple options" do
    a_normal_select = mock(:select)
    a_normal_select .stub(:tag_name).and_return('select')
    a_normal_select.should_receive(:attribute).with('multiple').and_raise(Selenium::WebDriver::Error::WebDriverError)

    select = Select.new(a_normal_select)
    select.multiple?.should be_false
  end

  it "should return all options when asked" do
    a_select = mock(:select)
    options = []

    a_select.stub(:tag_name).and_return('select')
    a_select.stub(:attribute?).with('multiple').and_return('multiple')
    a_select.should_receive(:find_elements).with(:tag_name, 'option').and_return(options)

    select = Select.new(a_select)
    returned_options = select.options

    returned_options.should equal(options)
  end

  it "should return options which are selected" do
    a_select = mock(:select)
    good_option = mock(:good_option)
    bad_option = mock(:bad_option)
    options = [bad_option, good_option]

    a_select.stub(:tag_name).and_return('select')
    a_select.stub(:attribute?).with('multiple').and_return('multiple')
    a_select.should_receive(:find_elements).with(:tag_name, 'option').and_return(options)
    bad_option.should_receive(:selected?).and_return(false)
    good_option.should_receive(:selected?).and_return(true)

    select = Select.new(a_select)
    returned_options = select.selected_options

    returned_options.length.should == 1
    returned_options[0].should equal(good_option)
  end
end