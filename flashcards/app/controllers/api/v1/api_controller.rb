module Api::V1
  class ApiController < ApplicationController
      include ActionController::Serialization
      include ActionController::HttpAuthentication::Basic

      protected

      # Attempt authentication and render an error if failed
      def attempt_authenticate
        authenticate_token || render_unauthorized
      end

      # Attempt an authentication
      def authenticate_token
        if has_basic_credentials?(request)
          user_id_and_token = user_name_and_password(request)
          @current_session = Session.find_by user: user_id_and_token[0], token: user_id_and_token[1]
          
          if @current_session
            return @current_user = @current_session.user
          end
        end
      end

      # Render an error
      def render_unauthorized(realm = "Application")
        render json: {'authorization' => ["basic-auth-id-or-header-incorrect"]}, status: :unauthorized
      end

  end
end