class Api::V1::HotelFacilitiesController < ApplicationController
  respond_to :json

  def index
    hotel_facilities = HotelFacility.all
    respond_with hotel_facilities.to_json
  end
end
