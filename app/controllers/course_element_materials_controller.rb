class CourseElementMaterialsController < ApplicationController
  def index
    @course_element = CourseElement.find(params[:course_element_id])
  end

  def new
    @material = CourseElementMaterial.new
    @course_element = CourseElement.find(params[:course_element_id])
  end

  def create
    @material = CourseElementMaterial.new(get_material_params)
    @course_element = CourseElement.find(params[:course_element_material][:course_element_id])
    if @material.save
      flash[:success] = 'Вы успешно создали раздатку'

      redirect_to course_element_materials_path(course_element_id: @course_element)
    else
      render 'new'
    end
  end

  private

  def get_material_params
    params.require(:course_element_material).permit(:title, :content, :element_type, :course_element_id)
  end
end