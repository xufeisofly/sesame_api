City.all.each do |city|
  city.update(poi_num: city.pois.length)
end
