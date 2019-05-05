class CitiesController < ApplicationController
  def index
    builder = City.all

    if params[:q].present?
      query = params[:q].gsub(/\s+/, '')
      builder = builder.where(
        "name LIKE ? OR pinyin LIKE ? OR py_cap LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%")
    elsif params[:letter].present?
      builder = builder.where(cap: params[:letter])
    end

    cities = builder.select(:id, :name, :cap, :pinyin)
    render json: {
      cities: cities.group_by(&:cap).as_json,
      next_letter: params[:letter] && params[:letter].next,
      has_data: cities.present?,
      search_cities: cities.as_json
    }
  end
end
