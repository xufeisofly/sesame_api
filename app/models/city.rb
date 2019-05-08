# frozen_string_literal: true

class City < ApplicationRecord
  has_many :city_tag_relations, dependent: :destroy
  has_many :tags, through: :city_tag_relations
  has_many :start_tickets, class_name: 'Ticket', foreign_key: :start_id, dependent: :destroy
  has_many :end_tickets, class_name: 'Ticket', foreign_key: :end_id, dependent: :destroy
  has_many :pois, dependent: :destroy
  belongs_to :default_poi, class_name: 'Poi'

  HOT_CITIES_KEY = 'hot_cities_key'
  HOT_CITIES_COUNT = 16

  class << self
    def hot_cities
      names = Redis.current.zrevrange(HOT_CITIES_KEY, 0, -1)
      self.where(name: names[0..HOT_CITIES_COUNT-1])
    end

    def hot_city_append(str)
      Redis.current.zincrby(HOT_CITIES_KEY, 1, str)
    end
  end
end
