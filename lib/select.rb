class Select
  def initialize(element)
    @element = element
    raise UnexpectedTagNameError.new if element.tag_name != 'select'
  end

  def multiple?
    @element.attribute('multiple') != nil
  end

  def options
    @element.find_elements(:tag_name, 'option')
  end

  def selected_options
    options.select { |option| option.selected? }
  end

  def first_selected_option
    options = selected_options
    raise NoSuchElementError if (options.length == 0)

    options[0]
  end

  def select_by_visible_text(text)
    
  end

  def select_by_index(index)
    
  end

  def select_by_value(value)
    
  end
end