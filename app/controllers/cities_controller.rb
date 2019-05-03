class CitiesController < ApplicationController
  def index
    cities = City.all
    render json: cities.group_by(&:cap).to_json
  end
end
