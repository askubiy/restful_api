class Api::V1::SearchController < ApplicationController
  respond_to :json

  def search

    errors = []

    begin
      if params[:start_date].blank? || params[:end_date].blank?
        errors << "Params start_date/end_date missed or wrong"
      else
        if (Date.parse(params[:end_date]) - Date.parse(params[:start_date])).to_i < 0
          errors << "Param start_date can't be bigger than end_date"
        end

        if (Date.parse(params[:start_date]) < Date.today || Date.parse(params[:end_date]) < Date.today)
          errors << "Params start_date/end_date can't be in the past"
        end

        if (Date.parse(params[:start_date]) == Date.parse(params[:end_date]))
          errors << "Param start_date and end_date can't be equal"
        end
      end
    rescue
      render json: { errors: ["Params start_date/end_date missed or wrong"] }, status: 400
      return
    end

    unless errors.blank?
      render json: { errors: errors }, status: 400
      return
    end

    #hotel_facilities_ids = ["1","2"]
    #room_facilities_ids = [1,2]
    #room_type_ids = [1,2]
    #end_date = "2016-02-23"
    #start_date = "2016-02-22"

    start_date = params[:start_date]
    end_date = params[:end_date]
    room_type_ids = params[:room_type_ids]
    hotel_facilities_ids = params[:hotel_facilities_ids]
    room_facilities_ids = params[:room_facilities_ids]

    periods_hotels_subquery = Hotel.select("rooms.id as hbs").joins(:rooms).joins(:booking_periods).where(period_booking: true).where("booking_periods.start_date = ? AND booking_periods.end_date = ?", start_date, end_date).to_sql

    rooms = Room.joins("LEFT JOIN orders ON rooms.id = orders.room_id")
      .joins("INNER JOIN 'hotels' 'hotels_rooms' ON rooms.hotel_id = hotels_rooms.id")
      .joins("LEFT JOIN (#{periods_hotels_subquery}) hb_sub ON hb_sub.hbs = rooms.id")
      .where("(hotels_rooms.period_booking = 'f' AND (((julianday(orders.start_date) - julianday(?)) * (julianday(?) - julianday(orders.end_date)) < 1) OR (orders.id IS NULL))) OR (hotels_rooms.period_booking = 't' AND hb_sub.hbs IS NOT NULL)", end_date, start_date)

    rooms = rooms.where(room_type_id: room_type_ids) unless room_type_ids.blank?

    unless room_facilities_ids.blank?
      room_facilities_subquery = RoomFacility.select("rooms_facilities.room_id as rf")
        .joins(:rooms).where(id: room_facilities_ids)
        .group("rooms_facilities.room_id")
        .having("count(rooms_facilities.room_id) = ?", room_facilities_ids.size).to_sql
      rooms = rooms.joins("INNER JOIN (#{room_facilities_subquery}) rf_sub ON rf_sub.rf = rooms.id")
    end

    unless hotel_facilities_ids.blank?
      hotel_facilities_subqury = HotelFacility.select("hotels_facilities.hotel_id as hf")
        .joins(:hotels).where(id: hotel_facilities_ids).group("hotels_facilities.hotel_id")
        .having("count(hotels_facilities.hotel_id) = ?", hotel_facilities_ids.size).to_sql
      rooms = rooms.joins("INNER JOIN (#{hotel_facilities_subqury}) hf_sub ON hf_sub.hf = rooms.hotel_id")
    end

    respond_with rooms.to_json(:include => [:room_facilities, :hotel])
  end
end