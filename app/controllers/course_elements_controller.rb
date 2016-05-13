class CourseElementsController < ApplicationController
  def new
    @course_element = CourseElement.new
    @course = Course.find(params[:course_id])
  end

  def create
    @course_element = CourseElement.new(get_course_element_params)
    if @course_element.save
      flash[:success] = 'Вы успешно создали тему'

      redirect_to show_course_index_url(@course_element.course, resource: 3)
    else
      @course = @course_element.course
      render action: 'new'
    end
  end


  private

  def get_course_element_params
    params.require(:course_element).permit(:theme, :element_type, :course_id)
  end

end
