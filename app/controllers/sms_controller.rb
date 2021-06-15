class SmsController < ApplicationController
  skip_before_action :http_authenticate, only: :index
  protect_from_forgery with: :null_session, only: %i(inbound outbound)

  # Home Page
  def index
  end

  def inbound
    user_inputs = InputValidator.new(current_account, params)
    if user_inputs.valid?
      render json: { 'message': 'inbound sms ok', 'error': '' }
    else
      render json: { 'message': '', 'error': user_inputs.errors.full_messages }
    end
  rescue
    render json: { 'message': '', 'error': 'unknown failure' }
  end

  def outbound
    user_inputs = InputValidator.new(current_account, params)
    if user_inputs.valid?
      render json: { 'message': 'outbound sms ok', 'error': '' }
    else
      render json: { 'message': '', 'error': user_inputs.errors.full_messages }
    end
  rescue
    render json: { 'message': '', 'error': 'unknown failure' }
  end

  # We have created this method to return HTTP code 405 as by default rails will
  # return 404 if no routes matches
  # We can also rescue it in application controller with
  # rescue_from ActionController::RoutingError
  def http_not_allowed
    head 405
  end
end
