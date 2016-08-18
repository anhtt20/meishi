module Api::V1
  class ApiController < ApplicationController
    # Generic API stuff here
    before_action :authenticate

    # rescue_from StandardError,
    #     with: lambda { |e| render_error(e) }
    #   Catch_Excetions = [
    #     ActionController::MethodNotAllowed,
    #     ActionController::UnknownHttpMethod
    #   ]

    protected
      
      def render_error(exception)
        status_code = ActionDispatch::ExceptionWrapper.new(env, exception).status_code
        # 必要なエラーだけ通知
        if Catch_Excetions.include?(exception)
          ExceptionNotifier.notify_exception(exception, env: env, data: params)
        end

        render json: get_error(status_code, exception.message, params),
            status: status_code
      end

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