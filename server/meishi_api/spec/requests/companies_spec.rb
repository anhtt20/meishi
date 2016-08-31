require 'rails_helper'

RSpec.describe "Companies", type: :request do
  describe "GET /companies" do
    it "works! (now write some real specs)" do
      get '/v1/companies'
      expect(response).to have_http_status(200)
    end
  end
end
