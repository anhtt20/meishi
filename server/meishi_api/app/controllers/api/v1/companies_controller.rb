module Api::V1
  class CompaniesController < ApiController

    #API06
    #GET /v1/companies
    def fetch
      @companies = Company.select(:name).where("deleted = 0 and name like '#{params[:keyword]}%'").distinct
      if @companies
        render_json(@companies, :ok)
      else
        render json: nil, status: :no_content
      end
    end
  end
end
