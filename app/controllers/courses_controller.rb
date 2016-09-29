class CoursesController < ApplicationController
  def index
    @courses = Course.all
    @users = User.all
    @resource = params[:resource_id]
    session[:referer] = request.original_url
    unless session[:referer].include? '?resource_id=2'
      session[:referer] += '?resource_id=2'
    end
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
    session[:referer] = request.original_url
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

  def render_group_students
    @group = Group.find(params[:id])
    students = []
    teachers = []
    get_sorted_list(students, teachers)
  end

  def render_performance_chart
    @group = Group.find(params[:id])
    students = []
    @chart_data = []
    @chart_attendance_data = []
    past_periods = Period.past(@group.id)
    @group.users.each do |user|
      students.push user # if student_access?(user)
    end
    get_homeworks_data(past_periods, students)
    get_attendance_data(past_periods, students)
  end

  def student_homeworks_data
    @user = User.find(params[:id])
    @student_group = Group.find(params[:group_id])
    periods = Period.past(@student_group.id)
    @student_homework_data = []
    Homework.where(user_id: @user, period_id: periods).joins(:period).order('periods.commence_datetime').each do |homework|
      period = Period.find(homework.period_id)
      @student_homework_data.push ["#{period.title.capitalize}", homework.score]
    end
  end



  private

  def get_course_params
    params.require(:course).permit(:name, :course_short_name, :cost, :practical_time, :theoretical_time, :discipline_title)
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


  def get_homeworks_data(past_periods, students)
    students.each do |student|
      student_avg_score = Homework.where(user_id: student.id, period_id: past_periods).average(:score)
      @chart_data.push ["#{student.surname.capitalize} #{student.name.capitalize}", student_avg_score]
    end
  end

  def get_attendance_data(past_periods, students)
    students.each do |student|
      @student_past_periods = Attendance.where(user_id: student.id, period_id: past_periods).count.ceil
      @student_past_periods = 1 if @student_past_periods == 0
      student_past_attended_periods = Attendance.where(user_id: student.id, period_id: past_periods, attended: true).count.ceil
      attendance_percent = (student_past_attended_periods * 100) / @student_past_periods
      attendance_percent.round.to_i
      @chart_attendance_data.push ["#{student.surname.capitalize} #{student.name.capitalize}", attendance_percent]
    end
  end


end
