class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found

  include Authenticable
  before_filter :authenticate_with_token!

  def render_not_found errors
    render json: { errors: errors.to_s }, status: 404
    true
  end

  def check_params required_params, params
    errors = []
    unless (required_params.all? {|s| params.key? s})
      errors << "Some of required params not set. Required params: " + required_params.join(", ")
      render json: { errors: errors.to_s }, status: 400
      return true
    end
  end
end
