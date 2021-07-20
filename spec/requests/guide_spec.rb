require 'rails_helper'

RSpec.describe "Guides", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/guide/index"
      expect(response).to have_http_status(:success)
    end
  end

end
