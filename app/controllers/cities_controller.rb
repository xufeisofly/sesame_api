class CitiesController < ApplicationController
  def index
    builder = City.all
    hot_cities = []

    if params[:q].present?
      query = params[:q].gsub(/\s+/, '')
      builder = builder.where(
        "name LIKE ? OR pinyin LIKE ? OR py_cap LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%")
    elsif params[:letter].present?
      builder = builder.where(cap: params[:letter])
      hot_cities = City.hot_cities
    end

    cities = builder.select(:id, :name, :cap, :pinyin)
    render json: {
      cities: cities.group_by(&:cap).as_json,
      next_letter: params[:letter] && params[:letter].next,
      has_data: cities.present?,
      search_cities: cities.as_json,
      hot_cities: hot_cities.as_json
    }
  end

  def add_hot
    City.hot_city_append params[:hot_city_name] if params[:hot_city_name].present?
  end
end
