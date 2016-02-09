module Authenticable

  # Devise methods overwrites
  def current_client
    @current_client ||= Client.find_by(auth_token: request.headers['Authorization'])
  end

  def authenticate_with_token!
    render json: { errors: "Not authenticated" },
                status: :unauthorized unless client_signed_in?
  end

  def client_signed_in?
    current_client.present?
  end
end