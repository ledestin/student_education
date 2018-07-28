require "rails_helper"

describe "Teacher management:" do
  include_context :json

  describe "get list of teachers" do
    it "returns all teachers" do
      teacher = create :teacher

      get "/teachers", headers: headers

      expect(response).to have_http_status(:ok)
      expect(json_body.size).to eq 1
      expect(json_body.first["id"]).to eq teacher.id
    end
  end
end
