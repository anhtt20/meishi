require 'rails_helper'

RSpec.describe "Companies", type: :request do

  before(:each) do 
    @user = FactoryGirl.create(:user)
    @role = FactoryGirl.create(:role)
    FactoryGirl.create(:map_role, { user_id: @user.user_id, role_id: @role.role_id })
    @token = FactoryGirl.create(:token, { user_id: @user.user_id })
  end

  describe "Get /v1/companies" do
    before do
      @companies = FactoryGirl.create_list(:company, 30)
    end

    it "works! (now write some real specs)" do
      #Call Action
      get '/v1/companies',headers: { 'Authorization' => 'Token token="zsR2GcNjUPiHOybIMdrzwwtt"' }

      json = JSON.parse(response.body)

      expect(response).to  have_http_status(200)

      expect(json.size).to eq @companies.count

    end
  end
end
