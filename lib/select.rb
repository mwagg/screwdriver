class Select
  def initialize(element)
    element.tag_name
    raise UnexpectedTagNameError.new
  end
end