class Select
  def initialize(element)
    @element = element
    raise UnexpectedTagNameError.new if element.tag_name != 'select'
  end

  def multiple?
    @element.attribute('multiple') 
    true
  end

end