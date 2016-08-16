module Api::V1
  class ApiController < ApplicationController
    # Generic API stuff here
    #before_action :authenticate_user!


    before_action :authenticate

    protected

      # Authenticate the user with token based authentication
      def authenticate
        authenticate_token || render_unauthorized
      end

      def authenticate_token
        authenticate_with_http_token do |token, options|
          @token = Token.find_by(token: token)
          if @token
            @t = Time.now
            render json: get_error(504, 'Token timeout', token) if @t.to_i > @token.expired_time.to_i
            
            @current_user = @token.user
          else
            false
          end
        end
      end

      def render_unauthorized(realm = "Application")
        self.headers["WWW-Authenticate"] = %(Token realm="#{realm.gsub(/"/, "")}")
        render json: get_error(401, 'Bad credentials', params), status: :unauthorized
      end

      def get_error(status, message, data)
        { 'status' => status, 'message' => message, 'data' => data }
      end
  end
end