require 'rubygems'
require 'selenium-webdriver'
require File.join(File.dirname(__FILE__), '../../lib/screwdriver')

driver = Selenium::WebDriver.for :firefox

Before do
  @driver = driver
end

at_exit do
  driver.quit
end