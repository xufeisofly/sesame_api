cities = City.all

cities.each do |city|
  pinyin = PinYin.sentence(city.name)
  py_cap = pinyin.split(' ').map(&:first).join
  cap = pinyin.first.capitalize

  city.update pinyin: pinyin.gsub(/\s+/, ''), cap: cap, py_cap: py_cap
end
