class StudentsController < ApplicationController
  respond_to :json

  def index
    students = params[:teacher_id] ?
      Student.where(teacher_id: params[:teacher_id]) :
      Student.all

    respond_with(students)
  end

  def show
    existing_student = Student.find(params[:id])
    respond_with(existing_student)
  end

  def update
    student = Student.find(params[:id])

    student.update(student_params)
  end

  private

  def student_params
    params.require(:student).permit(:completed_lesson, :completed_part)
  end
end
