class Poi < ApplicationRecord
  belongs_to :city

  after_create :incr_city_poi_num
  after_destroy :decr_city_poi_num

  def incr_city_poi_num
    self.city.increment!(:poi_num)
  end

  def decr_city_poi_num
    self.city.decrement!(:poi_num)
  end
end
