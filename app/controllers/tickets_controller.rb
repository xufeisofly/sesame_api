# frozen_string_literal: true

class TicketsController < ApplicationController
  def index
    from_city = City.find_by(name: params[:from])
    tag = Tag.find_by(category: params[:q]) if params[:q].present?

    tickets = Ticket.where(
      start_id: from_city.id, end_id: tag.cities.ids
    ).page(params[:page]).per(params[:limit])

    render_collection_with_page(tickets, {}, each_serializer: TicketSerializer)
  end
end
