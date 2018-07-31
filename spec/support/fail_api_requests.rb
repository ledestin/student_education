require "teachers_controller"

class TeachersController
  class << self
    attr_accessor :always_fail
    alias_method :always_fail?, :always_fail
  end

  before_action :fail_with_server_error

  def fail_with_server_error
    head :internal_server_error if self.class.always_fail?
  end
end

shared_context :fail_api_requests do
  after do
    TeachersController.always_fail = false
  end
end
