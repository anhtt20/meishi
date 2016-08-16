module Api::V1
  class RolesController < ApiController
    before_action :set_role, only: [:show, :update, :destroy]

    # GET /roles
    def get
      @role = Role.find(params[:role_id])
      
      render json: @role
    end
  end
end
