class CitiesController < ApplicationController
  def index
    cities = City.where(cap: params[:letter]).select(:id, :name, :cap, :pinyin)

    render json: {
      cities: cities.group_by(&:cap).as_json,
      next_letter: params[:letter].next,
      has_data: cities.present?
    }
  end
end
