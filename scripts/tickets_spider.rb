require 'selenium-webdriver'

driver = Selenium::WebDriver.for :chrome

url = "https://train.qunar.com/stationToStation.htm?fromStation=%E5%8C%97%E4%BA%AC&toStation=%E4%B8%8A%E6%B5%B7&date=2019-04-29&drainage="

wait = Selenium::WebDriver::Wait.new(:timeout => 20)

durations = wait.until do
  elements = driver.find_elements(:class, "duration")
end
