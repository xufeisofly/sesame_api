class PoisController < ApplicationController
  def index
    city = City.find_by(name: params[:city_name])
    render_collection(city.pois, {}, each_serializer: PoiSerializer)
  end
end
