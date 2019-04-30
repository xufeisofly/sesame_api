class Trip < ApplicationRecord
  belongs_to :end_city, class_name: 'City', foreign_key: :end_city_id, dependent: :destroy
  belongs_to :start_city, class_name: 'City', foreign_key: :start_city_id, dependent: :destroy
end
