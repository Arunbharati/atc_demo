module HttpAuthConcern
  extend ActiveSupport::Concern

  included do
    before_action :http_authenticate
  end

  def http_authenticate
    authenticate_or_request_with_http_basic do |username, password|
      # Check in the database to validate the user
      Account.where(username: username, auth_id: password).exists?
    end
  end
end
