require "rails_helper"

describe "Student management:" do
  let(:headers) { { "ACCEPT" => "application/json" } }
  let(:json_body) { JSON.parse response.body }

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