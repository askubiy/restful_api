class Api::V1::SessionsController < ApplicationController

  def create
    client_password = params[:session][:password]
    client_email = params[:session][:email]
    client = client_email.present? && Client.find_by(email: client_email)

    if client.valid_password? client_password
      sign_in client, store: false
      client.generate_authentication_token!
      client.save
      render json: client, status: 200, location: [:api, client]
    else
      render json: { errors: "Invalid email or password" }, status: 422
    end
  end

  def destroy
    client = Client.find_by(auth_token: params[:id])
    client.generate_authentication_token!
    client.save
    head 204
  end
end