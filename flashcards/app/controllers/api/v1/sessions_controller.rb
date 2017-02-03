module Api::V1
  class SessionsController < ApiController

    # POST /v1/login
    def login
      credentials = user_params

      @user = User.find_by(email: credentials[:email]).try(:authenticate, credentials[:password])

      if @user 
        create_token
      else
        render json: {'login' => ["email-or-pass-incorrect"]}, status: :unauthorized
      end

    end

    # POST /v1/logout
    def logout
      attempt_authenticate
      if @current_session 
        @current_session.delete
        render status: :ok
      end
    end

    private

    def create_token
      @session = Session.new(user: @user)

      if @session.save
        render json: @session, status: :created
      else
        render json: @session.errors, status: :unprocessable_entity
      end
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:email, :password)
    end

  end
end