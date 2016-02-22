class Api::V1::RoomFacilitiesController < ApplicationController
  respond_to :json

  def index
    room_facilities = RoomFacility.all
    respond_with room_facilities.to_json
  end
end
