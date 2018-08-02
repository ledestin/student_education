class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { errors: [exception.message] }, status: :bad_request
  end

  def render_failed_validation(model)
    render json: { errors: model.errors.full_messages }, status: :bad_request
  end
end
