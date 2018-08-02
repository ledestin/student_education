require "rails_helper"

describe "Teacher management:" do
  include_context :json

  let(:teacher_params) { { teacher: { name: "Batman" } } }
  let(:created_teacher) { Teacher.first }

  describe "create teacher" do
    it "creates a new teacher" do
      post "/teachers", params: teacher_params, headers: headers

      expect(response).to have_http_status(:created)
      expect(json_body).to include({ "name" => "Batman" })
      expect(created_teacher.id).to eq json_body["id"]
    end

    it "returns :bad_request if there's a validation error" do
      create :teacher, teacher_params[:teacher]
      post "/teachers", params: teacher_params, headers: headers

      expect(response).to have_http_status(:bad_request)
      expect(json_errors.size).to be > 0
      expect(Teacher.count).to eq 1
    end
  end

  describe "delete teacher" do
    let!(:teacher) { create :teacher }

    it "deletes teacher" do
      delete "/teachers/#{teacher.id}"

      expect(response).to have_http_status(:no_content)
      expect(Teacher.find_by id: teacher.id).to be_nil
    end

    it "returns :bad_request on invalid teacher id" do
      delete "/teachers/foo"

      expect(response).to have_http_status(:bad_request)
    end
  end

  describe "get list of teachers" do
    it "returns all teachers" do
      teacher = create :teacher, name: "Batman"

      get "/teachers", headers: headers

      expect(response).to have_http_status(:ok)
      expect(json_body.size).to eq 1
      expect(json_body.first).to \
        include({ "id" => teacher.id, "name" => "Batman" })
    end
  end

  describe "get a single teacher" do
    it "returns teacher" do
      teacher = create :teacher, name: "Batman"

      get "/teachers/#{teacher.id}", headers: headers

      expect(response).to have_http_status(:ok)
      expect(json_body).to include({"id" => teacher.id, "name" => "Batman" })
    end

    it "returns :bad_request on invalid teacher id" do
      get "/teachers/foo"

      expect(response).to have_http_status(:bad_request)
    end
  end

  describe "update teacher" do
    let!(:teacher) { create :teacher, name: "Batman" }

    it "updates name" do
      put "/teachers/#{teacher.id}", params: { teacher: { name: "Joker" } }

      teacher.reload
      expect(teacher.name).to eq "Joker"
    end

    it "returns :bad_request on validation errors" do
      create :teacher, name: "Joker"
      put "/teachers/#{teacher.id}", params: { teacher: { name: "Joker" } }

      expect(response).to have_http_status(:bad_request)
      expect(json_errors.size).to be > 0

      teacher.reload
      expect(teacher.name).to eq "Batman"
    end
  end
end
