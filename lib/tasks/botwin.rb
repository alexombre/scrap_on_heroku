require 'watir'
require 'pry'
require 'selenium-webdriver'
require 'json'
require 'date'

@proxy = {
    http: '159.8.114.37:8123'
}
Selenium::WebDriver::Firefox::Binary.path=ENV['FIREFOX_BIN']
Selenium::WebDriver::Firefox.driver_path =ENV['GECKODRIVER_PATH']
b = Watir::Browser.new :firefox, headless: true, proxy: @proxy
b.goto 'google.fr'





binding.pry
b.close
b = Watir::Browser.new :firefox, headless: true, proxy: @proxy
b.goto 'google.fr'





binding.pry
b.close