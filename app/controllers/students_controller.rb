class StudentsController < ApplicationController
  def update
    student = Student.find(params[:id])

    student.update(student_params)
  end

  private

  def student_params
    params.require(:student).permit(:completed_lesson, :completed_part)
  end
end
