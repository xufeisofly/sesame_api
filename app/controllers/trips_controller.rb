# frozen_string_literal: true

class TripsController < ApplicationController
  def index
    from_city_name = params[:from_city]
    duration_min = params[:duration][0].to_i * 60
    offset = params[:offset].to_i

    start_city = City.find_by(name: from_city_name)
    trips = Trip.where(
      'start_city_id = ? AND duration_min < ?',
      start_city.id,
      duration_min
    ).includes(:end_city).order('cities.poi_num DESC, duration_min ASC').page(offset + 1).per(100)

    render_collection_with_page(trips, {}, each_serializer: TripSerializer)
  end
end
