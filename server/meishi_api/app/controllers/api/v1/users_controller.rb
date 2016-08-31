module Api::V1
  class UsersController < ApiController
    skip_before_action :authenticate, only: [:sign_in, :sign_up]
    skip_after_action :update_expired_time, only: [:sign_in, :sign_up]
    #POST /sign_in
    def sign_in
      @user = User.find_by(email: params[:email])
      if @user and @user.authenticate(params[:password])

        #get current time
        token = create_key
        write_token(token, @user.roles)
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

    #POST /sign_up
    def sign_up
      #check params
      signIpRequire
      ActiveRecord::Base.transaction do
        #Create User
        @user = User.create(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation]);
        raise "ユーザー作成できません。" unless @user
        @role = Role.find_by(role_name: 'User')
        @maprole = MapRole.create(role_id: @role.role_id, user_id: @user.user_id)
        raise "ユーザー作成できません。" unless @maprole

        #Create bizcards
        @bc = BusinessCard.new
        @bc.create_by = @user.user_id
        @bc.email = @user.email
        @bc.owner_id = @user.user_id
        @bc.company_id = bz_company
        @bc.recieve_date = Time.now

        raise @bc.errors unless @bc.save

        render json: @user, status: :created
      end
    end

    private
    def signIpRequire
      params.require('email')
      params.require('password')
      params.require('password_confirmation')
    end

    #generate token key
    def generate_api_key
      loop do
        token = SecureRandom.base64.tr('+/=', 'Qrt')
        break token unless Token.exists?(token: token)
      end
    end

    def create_key
      @t = Time.now + 60*60
      token = generate_api_key
      Token.find(@user.user_id).destroy if Token.exists?(user_id: @user.user_id)
      Token.create(user_id: @user.user_id, token: token, expired_time: @t.to_i.to_s)
      token
    end

    def bz_company
      @company = Company.find_by(name: 'IDOM Inc', post_code: '100-6425')
      @company = Company.new(name: 'IDOM Inc', post_code: '100-6425', address: '東京都千代田丸の内2-7-3　東京ビル25階') unless @company

      raise @company.errors unless @company.save
      @company.company_id
    end
  end
end
