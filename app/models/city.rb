# frozen_string_literal: true

class City < ApplicationRecord
  has_many :city_tag_relations, dependent: :destroy
  has_many :tags, through: :city_tag_relations
  has_many :start_tickets, class_name: 'Ticket', foreign_key: :start_id, dependent: :destroy
  has_many :end_tickets, class_name: 'Ticket', foreign_key: :end_id, dependent: :destroy
end
