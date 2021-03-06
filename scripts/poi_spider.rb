options = Selenium::WebDriver::Chrome::Options.new

options.add_argument('--headless')
options.add_argument('--disable-gpu')
options.add_argument('window-size=1024,768')
options.add_argument("--disable-dev-shm-usage")

base_url = 'https://travel.qunar.com/search/all/'

cities = City.all.pluck(:name)
# cities = %w(北京 天津 上海 重庆 呼和浩特 乌鲁木齐 拉萨 银川 南宁 哈尔滨 长春 沈阳 石家庄 郑州 武汉 长沙 太原 济南 西安 南京 杭州 福州 广州 合肥 南昌 昆明 贵阳 兰州 西宁 海口 成都)

driver = Selenium::WebDriver.for :chrome, options: options

cities.each_with_index do |city, index|
  puts "#{index + 1}/#{cities.length}"
  url = base_url + city

  city = City.find_by name: city
  next if city.pois.any?

  driver.navigate.to url
  sleep(1)

  wait = Selenium::WebDriver::Wait.new(:timeout => 20)

  # 获取「景点列表」的 url
  elements = wait.until do
    driver.find_elements(:css, 'p.tags a')
  end

  poi_eles = elements.select { |ele| ele.text == '景点' }
  unless poi_eles.any?
    next
  end
  poi_url = poi_eles.first.attribute(:href)

  driver.navigate.to poi_url

  wait = Selenium::WebDriver::Wait.new(:timeout => 20)

  # 获取景点的名称
  elements = wait.until do
    driver.find_elements(:class, 'cn_tit')
  end

  en_elements = wait.until do
    driver.find_elements(:class, 'en_tit')
  end

  poi_names = elements.zip(en_elements).map do |ele, en_ele|
    ret = ele.text
    ret.slice! en_ele.text
    ret
  end

  puts poi_names

  poi_names.each do |name|
    city.pois.find_or_create_by(cn_name: name)
  end

  puts "---->" + city.name
end

driver.quit
