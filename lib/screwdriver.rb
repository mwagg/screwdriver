require 'rubygems'
require 'selenium-webdriver'

ROOT = File.expand_path(File.dirname(__FILE__))

unless $LOAD_PATH.any?{|lp| File.expand_path(lp) == ROOT }
  $LOAD_PATH.unshift(ROOT)
end

require 'select'
require 'unexpected_tag_name_error'
require 'no_such_element_error'