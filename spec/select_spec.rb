require 'spec'
require 'spec_helper'

describe Select do
  it "should throw an exception if the element is not a select element" do
    anchor_element = mock(:an_anchor)
    anchor_element.should_receive(:tag_name).and_return('a')
    running { Select.new(anchor_element)}.should raise_error UnexpectedTagNameError

    a_select = mock(:an_anchor)
    a_select.should_receive(:tag_name).and_return('select')
    running { Select.new(a_select)}.should_not raise_error

  end

  it "should indicate that a select can support multiple options" do
    select_element = mock(:select)
    select_element.stub(:tag_name).and_return('select')
    select_element.should_receive(:attribute).with('multiple').and_return('multiple')

    select = Select.new(select_element)
    select.multiple?.should be_true
  end

  it "should not indicate that a normal select supports multiple options" do
    select_element = mock(:select)
    select_element.stub(:tag_name).and_return('select')
    select_element.should_receive(:attribute).with('multiple').and_return(nil)

    select = Select.new(select_element)
    select.multiple?.should be_false
  end

  it "should return all options when asked" do
    select_element = mock(:select)
    options = []

    select_element.stub(:tag_name).and_return('select')
    select_element.stub(:attribute?).with('multiple').and_return('multiple')
    select_element.should_receive(:find_elements).with(:tag_name, 'option').and_return(options)

    select = Select.new(select_element)
    returned_options = select.options

    returned_options.should equal(options)
  end

  it "should return options which are selected" do
    select_element = mock(:select)
    good_option = mock(:good_option)
    bad_option = mock(:bad_option)
    options = [bad_option, good_option]

    select_element.stub(:tag_name).and_return('select')
    select_element.stub(:attribute?).with('multiple').and_return('multiple')
    select_element.should_receive(:find_elements).with(:tag_name, 'option').and_return(options)
    bad_option.should_receive(:selected?).and_return(false)
    good_option.should_receive(:selected?).and_return(true)

    select = Select.new(select_element)
    returned_options = select.selected_options

    returned_options.length.should == 1
    returned_options[0].should equal(good_option)
  end

  it "should return first selected options" do
    select_element = mock(:select_element)
    first_option = mock(:first_option)
    second_option = mock(:second_option)
    options = [first_option, second_option]

    select_element.stub(:tag_name).and_return('select')
    select_element.stub(:attribute?).with('multiple').and_return('multiple')
    select_element.should_receive(:find_elements).with(:tag_name, 'option').and_return(options)
    first_option.should_receive(:selected?).and_return(true)
    second_option.should_receive(:selected?).and_return(true)

    select = Select.new(select_element)
    first_selected = select.first_selected_option()

    first_selected.should equal(first_option)
  end

  it "should throw no such element error if nothing is selected" do
    select_element = mock(:select_element)
    first_option = mock(:first_option)
    options = [first_option]

    select_element.stub(:tag_name).and_return('select')
    select_element.stub(:attribute?).with('multiple').and_return('multiple')
    select_element.should_receive(:find_elements).with(:tag_name, 'option').and_return(options)
    first_option.should_receive(:selected?).and_return(false)

    select = Select.new(select_element)

    begin
      select.first_selected_option()
      raise('Should not have got here')
    rescue NoSuchElementError
    end
  end
end
