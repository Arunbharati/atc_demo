# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include HttpAuthConcern
  helper_method :current_account

  def current_account
    account, pass = ActionController::HttpAuthentication::Basic.user_name_and_password(request)
    if account
      @current_account ||= Account.find_by_username(account)
    else
      @current_account = nil
    end
  end
end
