class Api::V1::HotelsController < ApplicationController
  respond_to :json

  def index
    hotels = Hotel.all
    respond_with hotels
  end

  def show
    respond_with Hotel.find(params[:id])
  end
end
