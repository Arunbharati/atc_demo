# frozen_string_literal: true

class OutboundService
  attr_reader :from

  RESET_OUTBOUND_CACHE_TIME = ENV['RESET_OUTBOUND_CACHE_TIME'] # in seconds

  def initialize(params)
    @from = params[:from]
  end

  # Manage api call count in 24 hours
  def process
    key = "api_call_count_for_#{from}"
    data = $redis.get(key)

    if data.present?
      $redis.set(key, { 'count': JSON.parse(data)['count'] + 1 }.to_json, { keepttl: true }) == 'OK'
    else
      $redis.set(key, { 'count': 1 }.to_json, { ex: RESET_OUTBOUND_CACHE_TIME }) == 'OK'
    end
  end
end
