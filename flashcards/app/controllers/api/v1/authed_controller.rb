module Api::V1
  class AuthedController < ApiController
    before_action :attempt_authenticate

  end
end