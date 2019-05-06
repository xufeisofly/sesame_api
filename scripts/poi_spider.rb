options = Selenium::WebDriver::Chrome::Options.new

options.add_argument('--headless')
options.add_argument('--disable-gpu')
options.add_argument('window-size=1024,768')
options.add_argument("--disable-dev-shm-usage")

base_url = 'https://travel.qunar.com/search/all/'

cities = City.all.pluck(:name)

cities.each do |city|
  url = base_url + city

  driver = Selenium::WebDriver.for :chrome, options: options
  driver.navigate.to url

  wait = Selenium::WebDriver::Wait.new(:timeout => 20)

  # 获取「景点列表」的 url
  elements = wait.until do
    driver.find_elements(:css, 'p.tags a')
  end

  poi_eles = elements.select { |ele| ele.text == '景点' }
  next unless poi_eles.any?
  poi_url = poi_eles.first.attribute(:href)

  driver.navigate.to poi_url

  wait = Selenium::WebDriver::Wait.new(:timeout => 20)

  # 获取景点的名称
  elements = wait.until do
    driver.find_elements(:class, 'cn_tit')
  end

  poi_names = elements.map { |ele| ele.text }

  driver.quit

  poi_names.each do |name|
    Poi.find_or_create_by(name: name)
  end
end


