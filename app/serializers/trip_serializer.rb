class TripSerializer < ActiveModel::Serializer
  attributes :id, :to_city, :duration_min, :desc

  def to_city
    object.end_city.name
  end

  def desc
    default_name = object.end_city.default_poi&.cn_name || object.end_city.pois&.first&.cn_name
    return nil if default_name.blank?

    default_name + '等 ' + object.end_city.pois.length.to_s + ' 个景点'
  end

  def poi_num
    object.end_city.poi_num
  end
end
