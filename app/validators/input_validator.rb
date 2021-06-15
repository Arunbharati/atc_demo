# input validator for inbound and outbound sms
class InputValidator
  include ActiveModel::Validations

  attr_accessor :account, :from, :to, :text

  validates :from, :to, :text, presence: true
  validates :from, :to, length: { minimum: 6, maximum: 16,
                        message: 'should be between 6-16 digits'}
  validates :text, length: { minimum: 1, maximum: 120,
                   message: 'should be between 1-120'}
  validate :validate_to_input
  validate :validate_from_input

  def initialize(account, params = {})
    @account = account
    @from = params[:from]
    @to   = params[:to]
    @text = params[:text]
  end

  private

  # Validates 'to' input to check whether this belongs to logged in account
  def validate_to_input
    unless account.phone_numbers.where(number: to).exists?
      errors.add(:to, 'invalid')
    end
  end

  # Validates 'from' input to check whether this belongs to logged in account
  def validate_from_input
    unless account.phone_numbers.where(number: from).exists?
      errors.add(:from, 'invalid')
    end
  end
end
