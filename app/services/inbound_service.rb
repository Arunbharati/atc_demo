class InboundService
  attr_reader :to, :from, :text
  RESET_INBOUND_CACHE_TIME = ENV['RESET_INBOUND_CACHE_TIME'] # in seconds

  def initialize(params)
    @to   = params[:to]
    @from = params[:from]
    @text = params[:text]
  end

  # store 'from' and 'to' pair in cache as a unique entry and should
  # expire after 4 hours.
  def process
    if ['STOP', 'STOP\n', 'STOP\r', 'STOP\r\n'].include? text
      $redis.set("STOP_#{to}_#{from}", {}, { ex: RESET_INBOUND_CACHE_TIME }) == "OK"
    end
  end
end
