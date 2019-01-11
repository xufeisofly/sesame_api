cities = %w(北京 天津 上海 重庆 呼和浩特 乌鲁木齐 拉萨 银川 南宁 哈尔滨 长春 沈阳 石家庄 郑州 武汉 长沙 太原 济南 西安 南京 杭州 福州 广州 合肥 南昌 昆明 贵阳 兰州 西宁 海口 成都 香港 澳门 台北)

cities.each do |name|
  Tag.first.cities << City.find_by(name: name)
  puts name
end
