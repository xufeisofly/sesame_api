class Tag < ApplicationRecord
  has_many :city_tag_relations, dependent: :destroy
  has_many :cities, through: :city_tag_relations

  enum category: YAML.load_file('const.yml').fetch('tags')
end
