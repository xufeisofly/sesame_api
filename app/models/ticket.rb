class Ticket < ApplicationRecord
  belongs_to :start, class_name: 'City', foreign_key: :start_id
  belongs_to :end, class_name: 'City', foreign_key: :end_id
end
