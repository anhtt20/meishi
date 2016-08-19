module Api::V1
  class CompaniesController < ApiController

    #API06
    #GET /v1/companies
    def fetch
      @companies = Company.where(deleted: 0)
      if @companies
        render_json(@companies, :ok)
      else
        render json: nil, status: :no_content
      end
    end
  end
end
