class Api::V1::OrdersController < ApplicationController
  respond_to :json

  before_filter { check_params([:room_id, :hotel_id, :customer_name, :phone], params) }

  def create
    order = Order.new(order_params)
    if order.save
      render json: order.to_json, status: 201, location: api_orders_url
    else
      render json: { errors: order.errors }, status: 422
    end
  end

  private

    def order_params
      params.require(:order).permit(:customer_name,
        :phone, :start_date, :end_date,
        :hotel_id, :room_id
      ).merge(client_id: current_client.id)
    end
end
