class CourseElementMaterialsController < ApplicationController
  def index
    @course_element = CourseElement.find(params[:course_element_id])
  end
end
