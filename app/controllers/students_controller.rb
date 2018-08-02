class StudentsController < ApplicationController
  respond_to :json

  def index
    students = params[:teacher_id] ?
      Student.where(teacher_id: params[:teacher_id]) :
      Student.all

    respond_with(students)
  end

  def create
    new_student = Student.new student_params
    if new_student.save
      render json: new_student, status: :created
    else
      render_failed_validation new_student
    end
  end

  def show
    existing_student = Student.find(params[:id])
    respond_with(existing_student)
  end

  def update
    student = Student.find(params[:id])

    if student.update(student_params)
      render json: student, status: :ok
    else
      render_failed_validation(student)
    end
  end

  def destroy
    Student.find(params[:id]).destroy

    head :no_content
  end

  private

  def student_params
    params.require(:student).permit(:name, :teacher_id, :completed_lesson,
                                    :completed_part)
  end

  def render_failed_validation(student)
    render json: { errors: student.errors.full_messages }, status: :bad_request
  end
end
