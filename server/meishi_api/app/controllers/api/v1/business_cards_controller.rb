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
        raise "名刺には存在しております。" if BusinessCard.joins(:company).where(name: params[:name], email: params[:email], deleted: 0, 'companies.name' => params[:c_name]).exists?
        @bc = BusinessCard.new(bz_params)
        @bc.create_by = @current_user.user_id

        #Company
        @bc.company_id = bz_company if params[:c_name] and params[:c_post_code]
        #department
        @bc.department_id = bz_department if params[:d_name]
        #comments
        if params[:comment]
          @comment = Comment.create(content: params[:comment], create_by: @current_user.user_id)
          @bc.comment_id = @comment.comment_id
        end

        raise @bc.errors unless @bc.save

        #images
        bz_omt if params[:i_omt]
        bz_ura if params[:i_ura]
      end

      render_json(@bc, :created)
    end

    #API02
    #PUT /v1/business_cards/:id
    def update
      @bc = BusinessCard.find_by(business_card_id: params[:id], deleted: 0)
      raise "名刺情報は存在しておりません。" unless @bc
      raise "同じ名刺情報が存在しております。" if BusinessCard.joins(:company).where(name: params[:name], email: params[:email], deleted: 0, 'companies.name' => params[:c_name]).exists?

      ActiveRecord::Base.transaction do
        @bc.name = params[:name]
        @bc.email = params[:email]
        @bc.tel = params[:tel]
        @bc.furigana = params[:furigana]
        @bc.recieve_date = params[:recieve_date]
        @bc.update_by = @current_user.user_id

        #Company
        @bc.company_id = bz_company if params[:c_name] and params[:c_post_code]
        #department
        @bc.department_id = bz_department if params[:d_name]

        #images
        bz_omt if params[:i_omt]
        bz_ura if params[:i_ura]

        raise @bc.errors unless @bc.save
      end

      render_json(@bc, :ok)
    end

    #API03
    #GET /v1/business_cards/:id
    def show
      @bc = BusinessCard.find_by(business_card_id: params[:id], deleted: 0)
      raise "名刺情報は存在しておりません。" unless @bc
      render_json(@bc, :ok)
    end

    #API04
    #GET /v1/business_cards
    def fetch
      #require params
      search_required
      #is owner
      owner = params[:my_card] === '1' ? @current_user.user_id : nil
      #check next index
      next_index = params[:page_size].to_i * (params[:page].to_i - 1)
      #Query with conditions
      @bcs = BusinessCard.joins(:company, :department).
        where("(? is null or owner_id = ?) and (? is null or #{params[:search_by]} like '%#{params[:keyword]}%')", owner, owner, params[:keyword]).
        limit(params[:page_size]).offset(next_index).
        order("#{params[:order_by]} #{params[:asc]}")

      #no elements -> No_content
      if @bcs.size == 0
        render json: nil, status: :no_content
      else
        render_json(@bcs, :ok)
      end
    end

    #API05
    #DELETE /v1/business_cards/:id
    def destroy
      @bc = BusinessCard.find_by(business_card_id: params[:id], deleted: 0)
      raise "名刺情報は存在しておりません。" unless @bc
      raise "個人名刺には削除できません。" unless @bc.owner_id == @current_user.user_id
      @bc.deleted = 1
      raise @bc.errors unless @bc.save
      render json: nil, status: :no_content
    end

    private

    def search_required
      params.require(:search_by)
      params.require(:page)
      params.require(:page_size)

      params[:order_by] = 'business_cards.business_card_id' unless params[:order_by] and params[:order_by] != ''
      params[:asc] = 'DESC' if params[:asc] == '0'
      params[:asc] = 'ASC' unless params[:asc] and params[:asc] != '' and params[:asc] != '1'
    end

    def required_params
      params.require(:name)
      params.require(:email)
      params.require(:tel)
      params.require(:c_name)
      params.require(:c_address)
      params.require(:c_post_code)
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

    def bz_company
      @company = Company.find_by(name: params[:c_name], post_code: params[:c_post_code])
      @company = Company.new(name: params[:c_name], post_code: params[:c_post_code], create_by: @current_user.user_id) unless @company
      @company.address = params[:c_address]
      @company.email = params[:c_email]
      @company.tel = params[:c_tel]
      @company.fax = params[:c_fax]
      @company.url = params[:c_url]
      @company.deleted = 0
      @company.update_by = @current_user.user_id

      raise @company.errors unless @company.save
      @company.company_id
    end

    def bz_department
      @department = Department.find_by(name: params[:d_name])
      @department = Department.new(name: params[:d_name], create_by: @current_user.user_id) unless @department
      @department.update_by = @current_user.user_id
      @department.deleted = 0
      raise @department.errors unless @department.save
      @department.department_id
    end

    def bz_omt
      @omt = FileLocation.find_by(file_type: 'OMT', business_card_id: @bc.id)
      @omt = FileLocation.new(file_type: 'OMT', business_card_id: @bc.id, create_by: @current_user.user_id) unless @omt
      @omt.path = parse_image_data(params[:i_omt])
      @omt.domain = "images/"
      @omt.update_by = @current_user.user_id
      @omt.deleted = 0

      raise @omt.errors unless @omt.save
    end

    def bz_ura
      @ura = FileLocation.find_by(file_type: 'URA', business_card_id: @bc.id)
      @ura = FileLocation.new(file_type: 'URA', business_card_id: @bc.id, create_by: @current_user.user_id) unless @ura
      @ura.path = parse_image_data(params[:i_ura])
      @ura.domain = "images/"
      @ura.update_by = @current_user.user_id
      @ura.deleted = 0

      raise @ura.errors unless @ura.save
    end
  end
end
