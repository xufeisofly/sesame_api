options = Selenium::WebDriver::Chrome::Options.new

options.add_argument('--headless')
options.add_argument('--disable-gpu')
options.add_argument('window-size=1024,768')
options.add_argument("--disable-dev-shm-usage")

driver = Selenium::WebDriver.for :chrome, options: options

base_url = 'https://train.qunar.com/stationToStation.htm'

# cities = %w(北京 天津 上海 重庆 呼和浩特 乌鲁木齐 拉萨 银川 南宁 哈尔滨 长春 沈阳 石家庄 郑州 武汉 长沙 太原 济南 西安 南京 杭州 福州 广州 合肥 南昌 昆明 贵阳 兰州 西宁 海口 成都)
cities = City.all.pluck(:name)

def get_durations_in_mins(driver, url)
  driver.navigate.to url

  wait = Selenium::WebDriver::Wait.new(:timeout => 20)

  datas = wait.until do
    driver.find_elements(:class, "tr")
  end

  # 只限于高铁
  datas = datas.select { |data| data.text.first == 'G' }

  durations = datas.map do |data|
    str = data.text
    arr = str.split(/\n/)
    arr[8]
  end

  mins = durations.map do |duration|
    ret = duration.split(/小时|分/)
    ret[-1].to_i + ret[-2].to_i * 60
  end

  mins
end

begin
  cities.combination(2).each do |start_name, end_name|
    start_city = City.find_by(name: start_name)
    end_city = City.find_by(name: end_name)

    next if Trip.find_by(start_city_id: start_city.id, end_city_id: end_city.id).present?
    url = base_url + "?fromStation=#{start_name}&toStation=#{end_name}&date=2019-05-05&drainage="

    duration_mins = get_durations_in_mins(driver, url)
    sleep(1)
    puts "#{start_name}-#{end_name}: #{duration_mins.min}"

    Trip.find_or_create_by(
      start_city_id: start_city.id,
      end_city_id: end_city.id,
      duration_min: duration_mins.min
    ) if duration_mins.min.present?
  end
ensure
  driver.quit
end
