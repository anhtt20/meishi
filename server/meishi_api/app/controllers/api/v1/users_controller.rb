module Api::V1
  class UsersController < ApiController
    skip_before_action :authenticate, only: [:sign_in]
    #POST /sign_in
    def sign_in
      @user = User.find_by(email: params[:email])
      if @user and @user.authenticate(params[:password])

        #get current time
        create_key        
        render json: @user, status: :created
      else
        render json: get_error(401, "ログイン認証できない。", params), status: :unauthorized
      end
    end

    #DELETE /sign_out
    def sign_out
      @current_user.token.destroy

      render json: {}, status: :no_content
    end

    private
      #generate token key
      def generate_api_key
        loop do
          token = SecureRandom.base64.tr('+/=', 'Qrt')
          break token unless Token.exists?(token: token)
        end
      end

      def create_key
        @t = Time.now + 60*60
        Token.find(@user.user_id).destroy if Token.exists?(user_id: @user.user_id)
        Token.create(user_id: @user.user_id, token: generate_api_key, expired_time: @t.to_i.to_s)
      end
  end
end
