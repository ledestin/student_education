require "rails_helper"

describe "Student management:" do
  it "updates completed lesson progress" do
    new_student = create :student, completed_lesson: 1, completed_part: 1

    put "/students/#{new_student.id}",
      params: { student: { completed_lesson: 2, completed_part: 2 } }

    new_student.reload
    expect(new_student.completed_lesson).to eq 2
    expect(new_student.completed_part).to eq 2
  end
end
