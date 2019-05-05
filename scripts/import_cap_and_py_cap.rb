cities = City.all

cities.each do |city|
  pinyin = PinYin.sentence(city.name)
  cap = pinyin.first.capitalize

  city.update pinyin: pinyin, cap: cap
end
