class TripSerializer < ActiveModel::Serializer
  attributes :id, :to_city, :duration_min

  def to_city
    object.end_city.name
  end
end
