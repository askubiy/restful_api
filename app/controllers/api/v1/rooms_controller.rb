class Api::V1::RoomsController < ApplicationController
  respond_to :json

  def index
    rooms = Room.all
    respond_with rooms
  end

  def show
    respond_with Room.find(params[:id])
  end
end
