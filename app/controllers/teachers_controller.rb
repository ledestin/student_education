class TeachersController < ApplicationController
  respond_to :json

  def index
    respond_with Teacher.all
  end
end
