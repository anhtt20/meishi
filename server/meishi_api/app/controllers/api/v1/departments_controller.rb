module Api::V1
  class DepartmentsController < ApiController

    #API09
    #GET /v1/departments
    def fetch
      @departments = Department.where(deleted: 0)
      if @departments
        render_json(@departments, :ok)
      else
        render json: nil, status: :no_content
      end
    end
  end
end
