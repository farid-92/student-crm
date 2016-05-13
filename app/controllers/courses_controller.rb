class CoursesController < ApplicationController
  def index
    @courses = Course.all
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(get_course_params)
    if @course.save
      flash[:success] = 'Вы успешно создали курс'

      redirect_to courses_url
    else
      render action: 'new'
    end
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    if @course.update(get_course_params)
      flash[:success] = 'Вы успешно отредактировали курс'

      redirect_to courses_url
    else
      render 'edit'
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    flash[:danger] = 'Вы удалили курс'

    redirect_to courses_url
  end


  private

  def get_course_params
    params.require(:course).permit(:name, :course_short_name, :cost, :practical_time, :theoretical_time)
  end

end
