class TeachersController < ApplicationController
  respond_to :json

  def index
    respond_with Teacher.all
  end

  def create
    new_teacher = Teacher.new teacher_params
    if new_teacher.save
      render json: new_teacher, status: :created
    else
      render_failed_validation new_teacher
    end
  end

  def show
    respond_with Teacher.find(params[:id])
  end

  def update
    teacher = Teacher.find(params[:id])

    if teacher.update(teacher_params)
      render json: teacher, status: :ok
    else
      render_failed_validation(teacher)
    end
  end

  def destroy
    Teacher.find(params[:id]).destroy

    head :no_content
  end

  private

  def teacher_params
    params.require(:teacher).permit(:name)
  end
end
