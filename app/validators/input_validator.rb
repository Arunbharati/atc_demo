# frozen_string_literal: true

# input validator for inbound and outbound sms
class InputValidator
  include ActiveModel::Validations

  attr_accessor :account, :from, :to, :text, :requester

  validates :from, :to, :text, presence: true
  validates :from, :to, length: { minimum: 6, maximum: 16,
                                  message: I18n.t('errors.messages.invalid') }
  validates :text, length: { minimum: 1, maximum: 120,
                             message: I18n.t('errors.messages.invalid') }
  validate :validate_to_input, :validate_from_input, :stop_request,
           :validate_api_call_count

  def initialize(account, requester, params = {})
    @account = account
    @requester = requester
    @from = params[:from]
    @to   = params[:to]
    @text = params[:text]
  end

  private

  # Validates 'to' input to check whether this belongs to logged in account
  def validate_to_input
    if inbound_request? && !account.phone_numbers.where(number: to).exists?
      errors.add(:to, I18n.t('errors.messages.parameter_not_found'))
    end
  end

  # Validates 'from' input to check whether this belongs to logged in account
  def validate_from_input
    if outbound_request? && !account.phone_numbers.where(number: from).exists?
      errors.add(:from, I18n.t('errors.messages.parameter_not_found'))
    end
  end

  # Check to validate STOP request
  def stop_request
    if outbound_request? && $redis.get("STOP_#{to}_#{from}").present?
      errors.add(:base, message: "sms from #{from} to #{to} blocked by STOP request")
    end
  end

  # validate api call count in 24 hours
  def validate_api_call_count
    if outbound_request?
      data = $redis.get("api_call_count_for_#{from}")
      errors.add(:base, message: "limit reached for from #{from}") if data && JSON.parse(data)['count'] > 50
    end
  end

  # Is it called from inbound api
  def inbound_request?
    requester == 'inbound'
  end

  # Is it called from outbound api
  def outbound_request?
    requester == 'outbound'
  end
end
