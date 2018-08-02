require "rails_helper"

describe "Student management:" do
  include_context :json

  let!(:teacher) { create :teacher }
  let(:student_params) { { student: { name: "Batman" } } }
  let(:empty_name_student_params) { { student: { completed_lesson: "foo" } } }
  let(:created_student) { Student.first }

  describe "create student" do
    it "creates a new student" do
      post "/students", params: student_params, headers: headers

      expect(response).to have_http_status(:created)
      expect(json_body).to include({ "name" => "Batman" })
      expect(created_student.id).to eq json_body["id"]
    end

    it "returns :bad_request if there's a validation error" do
      post "/students", params: empty_name_student_params, headers: headers

      expect(response).to have_http_status(:bad_request)
      expect(json_errors.size).to be > 0
      expect(created_student).to be_nil
    end
  end

  describe "delete student" do
    let!(:student) { create :student }

    it "deletes student" do
      delete "/students/#{student.id}"

      expect(response).to have_http_status(:no_content)
      expect(Student.find_by id: student.id).to be_nil
    end

    it "returns :bad_request on invalid student id" do
      delete "/students/foo"

      expect(response).to have_http_status(:bad_request)
    end
  end

  describe "get list of students" do
    it "returns all students" do
      create_list :student, 10, completed_lesson: 1, completed_part: 2

      get "/students", headers: headers

      expect(response).to have_http_status(:ok)
      expect(json_body.size).to eq 10
      expect(json_body.first["completed_lesson"]).to eq 1
    end

    it "returns all students, belonging to the teacher" do
      student_without_teacher = create :student
      student_with_teacher = create :student, teacher: teacher

      get "/students?teacher_id=#{teacher.id}", headers: headers

      expect(response).to have_http_status(:ok)
      expect(json_body.size).to eq 1
      expect(json_body.first["id"]).to eq student_with_teacher.id
    end
  end

  describe "get a single student" do
    it "returns student and their progress" do
      new_student = create :student, name: "Batman", completed_lesson: 3,
        completed_part: 2, teacher_id: teacher.id

      get "/students/#{new_student.id}", headers: headers

      expect(response).to have_http_status(:ok)
      expect(json_body).to include("id" => new_student.id, "name" => "Batman",
                                   "completed_lesson" => 3,
                                   "completed_part" => 2,
                                   "teacher_id" => teacher.id)
    end

    it "returns :bad_request on invalid student id" do
      get "/students/foo"

      expect(response).to have_http_status(:bad_request)
    end
  end

  describe "update student" do
    let!(:new_student) do
      create :student, completed_lesson: 1, completed_part: 1
    end

    it "updates completed lesson progress" do
      put "/students/#{new_student.id}",
        params: { student: { completed_lesson: 2, completed_part: 2,
                             teacher_id: teacher.id } }

      new_student.reload
      expect(new_student.completed_lesson).to eq 2
      expect(new_student.completed_part).to eq 2
      expect(new_student.teacher_id).to eq teacher.id
    end

    it "returns :bad_request on validation errors" do
      put "/students/#{new_student.id}",
        params: { student: { completed_part: 4 } }

      expect(response).to have_http_status(:bad_request)
      expect(json_errors.size).to be > 0

      new_student.reload
      expect(new_student.completed_part).to eq 1
    end
  end
end
