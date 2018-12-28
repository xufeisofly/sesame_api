# frozen_string_literal: true

class TicketsController < ApplicationController
  def index
    route = OpenStruct.new(
      from: params[:from], to: params[:to], date: params[:date]
    )
    tickets = TicketSearchService.new(route).call
    render json: { data: tickets }
  end
end
