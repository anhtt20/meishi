module Api::V1
  class DepartmentsController < ApiController

    #API09
    #GET /v1/departments
    def fetch
      @departments = Department.select(:name).where("deleted = 0 and name like '#{params[:keyword]}%'").distinct
      if @departments
        render_json(@departments, :ok)
      else
        render json: nil, status: :no_content
      end
    end
  end
end
