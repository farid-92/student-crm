class CoursesController < ApplicationController
  def index
    @courses = Course.all
    @users = User.all
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

  def course_index
    @course = Course.find(params[:id])
    @resource = params[:resource]
  end

  def course_groups
    @course = Course.find(params[:id])
  end

  def course_elements
    @course = Course.find(params[:id])
  end

  def group_index
    @group = Group.find(params[:id])
    @resource = params[:resource]
    students = []
    teachers = []
    get_sorted_list(students, teachers)
    get_uniq_study_units
    get_group_study_units
    get_all_group_periods
    get_group_students
  end

  private

  def get_course_params
    params.require(:course).permit(:name, :course_short_name, :cost, :practical_time, :theoretical_time)
  end

  def get_sorted_list(students, teachers)
    @sorted_list = []
    @group.users.each do |user|
      students.push user # if student_access?(user)
     # teachers.push user if teacher_access?(user)
    end
    @sorted_list = teachers + students
  end

  def get_uniq_study_units
    @study_units = []
    @group.study_units.each do |study_unit|
      @study_units.push study_unit
    end
    @study_units.uniq!
  end

end
