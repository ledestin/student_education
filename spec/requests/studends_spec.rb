require "rails_helper"

describe "Student management:" do
  include_context :json

  describe "get list of students" do
    it "returns all students" do
      create_list :student, 10, completed_lesson: 1, completed_part: 2

      get "/students", headers: headers

      expect(response).to have_http_status(:ok)
      expect(json_body.size).to eq 10
      expect(json_body.first["completed_lesson"]).to eq 1
    end

    it "returns all students, belonging to the teacher" do
      teacher = create :teacher
      student_without_teacher = create :student
      student_with_teacher = create :student, teacher: teacher

      get "/students?teacher_id=#{teacher.id}", headers: headers

      expect(response).to have_http_status(:ok)
      expect(json_body.size).to eq 1
      expect(json_body.first["id"]).to eq student_with_teacher.id
    end
  end

  it "updates completed lesson progress" do
    new_student = create :student, completed_lesson: 1, completed_part: 1

    put "/students/#{new_student.id}",
      params: { student: { completed_lesson: 2, completed_part: 2 } }

    new_student.reload
    expect(new_student.completed_lesson).to eq 2
    expect(new_student.completed_part).to eq 2
  end

  it "returns student and their progress" do
    new_student = create :student, name: "Batman", completed_lesson: 3,
      completed_part: 2

    get "/students/#{new_student.id}", headers: headers

    expect(response).to have_http_status(:ok)
    expect(json_body).to include("id" => new_student.id, "name" => "Batman",
                                 "completed_lesson" => 3, "completed_part" => 2)
  end
end
