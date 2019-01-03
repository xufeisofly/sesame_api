# frozen_string_literal: true

require 'json'
require 'net/http'
require 'cacheable'

class TicketSearchService
  attr_reader :from_code, :to_code, :date
  PROXY_IPPOOL_KEY = 'ippoolkey'

  def initialize(route)
    @from_code = convert_to_code route.from
    @to_code = convert_to_code route.to
    @date = route.date
  end

  def call
    res = Net::HTTP.get(left_tickets_uri(from_code, to_code, date))
    return [] if res.blank?

    res = JSON.parse(res).dig('data', 'result')
    dump_data(res)
  end

  private

  def convert_to_code(name)
    City.find_by(name: name).code
  end

  def left_tickets_uri(from_code, to_code, date)
    URI('https://kyfw.12306.cn/otn/leftTicket/'\
        "queryZ?leftTicketDTO.train_date=#{date}"\
        "&leftTicketDTO.from_station=#{from_code}"\
        "&leftTicketDTO.to_station=#{to_code}&purpose_codes=ADULT")
  end

  def dump_data(routes)
    routes.reduce([]) do |results, route|
      arr = route.split('|')
      results << {
        train_no: arr[3],
        start_time: arr[8],
        end_time: arr[9],
        duration: arr[10]
      }
    end
  end
end
