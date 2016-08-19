module Api::V1
  class ApiController < ApplicationController
    # Generic API stuff here
    before_action :authenticate
    after_action :update_expired_time

    rescue_from StandardError,
      with: lambda { |e| render_error(e) }


    protected

    def render_error(exception)
      status_code = ActionDispatch::ExceptionWrapper.new(request.env, exception).status_code

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

    def update_expired_time
      @new_expired = Time.now + 60*60
      @token.expired_time = @new_expired.to_i unless @new_expired.to_i - @token.expired_time.to_i < 2
      @token.save
    end

    def write_token(token, roles)
      roles_array = []
      roles.each { |role| roles_array.push(role.role_name) }
      self.headers["hh-token"] = token
      self.headers["hh-roles"] = roles_array.map(&:inspect).join(',')
    end

    def render_json(json, status)
      render json: json, status: status,
        scope: { action: params[:action], user_id: @current_user.user_id, controller: params[:controller] }
    end
  end
end
