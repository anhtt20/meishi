require 'rails_helper'

RSpec.describe "Departments", type: :request do

  before(:each) do 
    @user = FactoryGirl.create(:user)
    @role = FactoryGirl.create(:role)
    FactoryGirl.create(:map_role, { user_id: @user.user_id, role_id: @role.role_id })
    @token = FactoryGirl.create(:token, { user_id: @user.user_id })
      
    @departments = FactoryGirl.create_list(:department, 2)
  end


  describe "GET /v1/departments" do

    it "401 unauthorized" do
      get '/v1/departments'

      expect(response).to have_http_status(401)
    end

    it "Get all departments" do
      get '/v1/departments',headers: { 'Authorization' => 'Token token="zsR2GcNjUPiHOybIMdrzwwtt"' }

      #ステータスコードの認証
      expect(response).to have_http_status(200)

      #JSONの認証
      json = JSON.parse(response.body)

      expect(json.size).to                  eq @departments.count
      expect(json[0]['name']).to            eq @departments[0].name
      expect(json[0]['department_id']).to   eq @departments[0].department_id
    end

    it "Get with keyword 'Dept OnlyMe'" do
        
      FactoryGirl.create(:department, {name: "Dept OnlyMe"})

      get '/v1/departments',
            params: { keyword: 'Dept OnlyMe' },
            headers: { 'Authorization' => 'Token token="zsR2GcNjUPiHOybIMdrzwwtt"' }

      #ステータスコードの認証
      expect(response).to have_http_status(200)

      #JSONの認証
      json = JSON.parse(response.body)

      expect(json.size).to        eq 1
      expect(json[0]['name']).to  eq "Dept OnlyMe"
    end

    it "Get with keyword 'Notthing'" do
      get '/v1/departments',
            params: { keyword: 'Notthing' },
            headers: { 'Authorization' => 'Token token="zsR2GcNjUPiHOybIMdrzwwtt"' }

      #ステータスコードの認証
      expect(response).to have_http_status(200)

      #JSONの認証
      json = JSON.parse(response.body)

      expect(json.size).to        eq 0
    end
  end
end
