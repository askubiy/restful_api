class Api::V1::ClientsController < ApplicationController
  #before_action :authenticate_with_token!, only: [:update, :destroy]
  respond_to :json

  def show
    respond_with Client.find(params[:id])
  end

  def create
    client = Client.new(client_params)
    if client.save
      render json: client, status: 201, location: [:api, client]
    else
      render json: { errors: client.errors }, status: 422
    end
  end

  def update
    client = current_client

    if client.update(client_params)
      render json: client, status: 200, location: [:api, client]
    else
      render json: { errors: client.errors }, status: 422
    end
  end

  def destroy
    current_client.destroy
    head 204
  end

  private

    def client_params
      params.require(:client).permit(:email, :password, :password_confirmation)
    end
end
