module Api::V1
  class BusinessCardsController < ApiController

  	#API01
  	#POST /v1/business_cards
    def create
      #check params
      required_params
      #start transaction
      ActiveRecord::Base.transaction do
        #Add new instance for business card
        raise "名刺には存在しております。" if BusinessCard.joins(:company).where(name: params[:name], email: params[:email], 'companies.name' => params[:c_name]).exists?
        @bc = BusinessCard.new(bz_params)
        @bc.create_by = @current_user.user_id

        logger.error "エラー情報"
        #Company
        @company = Company.find_by(name: params[:c_name], post_code: params[:c_post_code])
        @company = Company.new(name: params[:c_name], post_code: params[:c_post_code], create_by: @current_user.user_id) unless @company
        @company.address = params[:c_address]
        @company.email = params[:c_email]
        @company.tel = params[:c_tel]
        @company.fax = params[:c_fax]
        @company.url = params[:c_url]
        @company.update_by = @current_user.user_id

        raise @company.errors unless @company.save
        @bc.company_id = @company.company_id
        #department
        @department = Department.find_by(name: params[:d_name])
        @department = Department.new(name: params[:d_name], create_by: @current_user.user_id) unless @department
        @department.update_by = @current_user.user_id
        raise @department.errors unless @department.save
        @bc.department_id = @department.department_id
        #comments
        if params[:comment]
          @comment = Comment.create(content: params[:comment], create_by: @current_user.user_id)
          @bc.comment_id = @comment.comment_id
        end

        raise @bc.errors unless @bc.save

        #images
        if params[:i_omt]
          @omt = FileLocation.new(file_type: 'OMT', business_card_id: @bc.id, create_by: @current_user.user_id)
          @omt.path = parse_image_data(params[:i_omt])
          @omt.domain = "#{Rails.public_path}/images/"

          raise @omt.errors unless @omt.save
        end

        #images
        if params[:i_ura]
          @ura = FileLocation.new(file_type: 'URA', business_card_id: @bc.id, create_by: @current_user.user_id)
          @ura.path = parse_image_data(params[:i_ura])
          @ura.domain = "#{Rails.public_path}/images/"

          raise @ura.errors unless @ura.save
        end
      end

      render json: @bc, status: :created
    end

    

    private
    def required_params
      params.require(:name)
      params.require(:email)
      params.require(:tel)
      params.require(:c_name)
      params.require(:c_address)
      params.require(:c_post_code)
      params.require(:d_name)
      params.require(:i_omt)
    end

    def bz_params
      params.permit(:name, :furigana, :email, :tel, :recieve_date)
    end

    def parse_image_data(image_data)
      tmp_name = "#{SecureRandom.base64.tr('+/=', 'Qrt')}#{Time.now.to_i}.png"
      png = Base64.decode64(image_data['data:image/png;base64,'.length .. -1])
      File.open("#{Rails.public_path}/images/#{tmp_name}", 'wb') do|f|
        f.write(png)
      end
      tmp_name
    end
  end
end
