require 'spec'
require 'spec/spec_helper'

describe Select do

  it "should throw an exception if the element is not a select element" do
    element = mock(:element)
    element.should_receive(:tag_name).and_return('a') 
    lambda { Select.new(element)}.should raise_error UnexpectedTagNameError 
  end
end