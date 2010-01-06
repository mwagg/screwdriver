class Select
  def initialize(element)
    @element = element
    raise UnexpectedTagNameError.new if element.tag_name != 'select'
  end

  def multiple?
    begin
      @element.attribute('multiple')
    rescue Selenium::WebDriver::Error::WebDriverError
      return false
    end

    return true
  end

  def options
    @element.find_elements(:tag_name, 'option')
  end

  def selected_options
    options.select { |option| option.selected? }
  end
end