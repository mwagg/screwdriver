class Pages
  def self.url_for(page_name)
    file_name = case (page_name)
      when 'basic select'
        'basic_select.xhtml'
      when 'multiple select'
        'multiple_select.xhtml'
      when 'selected options'
        'selected_options.xhtml'
      when 'selecting options'
        'selecting_options.xhtml'
      else
        raise "Unknown page '#{page_name}'"
    end

    path = File.expand_path(File.join('test_pages', file_name))

    "file://#{path}"
  end
end