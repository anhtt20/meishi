require 'rails_helper'

RSpec.describe "Companies", type: :request do

  before(:each) do 
    @user = FactoryGirl.create(:user)
    @role = FactoryGirl.create(:role)
    FactoryGirl.create(:map_role, { user_id: @user.user_id, role_id: @role.role_id })
    @token = FactoryGirl.create(:token, { user_id: @user.user_id })
    
    @companies = FactoryGirl.create_list(:company, 2)
  end

  describe "Get /v1/companies" do

    it "get all companies" do
      #Call Action
      get '/v1/companies',headers: { 'Authorization' => 'Token token="zsR2GcNjUPiHOybIMdrzwwtt"' }

      #ステータスコードの認証
      expect(response).to have_http_status(200)

      #JSONの認証
      json = JSON.parse(response.body)

      expect(json.size).to              eq @companies.count
      expect(json[0]['name']).to        eq @companies[0].name
    end

    it "401 unauthorized" do
      get '/v1/companies'

      expect(response).to have_http_status(401)
    end

    it "Get with keyword 'Company notthing'" do
      #Call Action
      get '/v1/companies',
          params: { keyword: "Company notthing" },
          headers: { 'Authorization' => 'Token token="zsR2GcNjUPiHOybIMdrzwwtt"' }

      #ステータスコードの認証
      expect(response).to have_http_status(200)

      #JSONの認証
      json = JSON.parse(response.body)

      expect(json.size).to eq 0
    end
  end
end
