class TicketSerializer < ActiveModel::Serializer
  attributes :start_name, :end_name, :train_no, :duration

  def start_name
    object.start.name
  end

  def end_name
    object.end.name
  end
end
