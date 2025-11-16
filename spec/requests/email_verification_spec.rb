require 'rails_helper'

RSpec.describe "EmailVerifications", type: :request do
  describe "GET /sent" do
    it "returns http success" do
      get email_verification_sent_path
      expect(response).to have_http_status(:success)
    end
  end

end
