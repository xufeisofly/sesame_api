class CityTagRelation < ApplicationRecord
  belongs_to :city
  belongs_to :tag
end
