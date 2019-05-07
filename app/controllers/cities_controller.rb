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

  def position_to_city
    lon = params[:lon]
    lat = params[:lat]

    baidu_url = 'http://api.map.baidu.com'

    conn = Faraday.new(url: baidu_url)
    baidu_params = {
      location: "#{lat},#{lon}",
      output: 'json',
      pois: 1,
      latest_admin: 1,
      ak: 'rpayOLzf0GU1XhNCLXYbOqeb8ivEf6Ql'
    }
    res = conn.get '/geocoder/v2/', baidu_params
    ret = JSON.parse res.body
    city_name = ret.dig('result','addressComponent', 'city').gsub('市', '')

    render json: { ret: city_name }
  end
end
