module Report

  def index
    teacher = current_student
    get_teacher_courses(teacher)
  end

  def sort_by_date
    @group = Group.find(params[:id])
    start_date = params[:start_date].to_s.to_date
    end_date = params[:end_date].to_s.to_date

    get_group_students
    @periods = []
    @periods = Period.where(group_id: @group.id, commence_datetime: start_date..end_date).order(:commence_datetime)
  end

  def current_study_unit
    @group = Group.find(params[:id])
    @periods = []
    get_group_students
    group_study_units = get_group_study_units
    return if group_study_units.nil?

    group_study_units.each do |study_unit|
      if study_unit.periods.order(:commence_datetime).first.commence_datetime.to_date <= Date.today && study_unit.periods.order(:commence_datetime).last.commence_datetime.to_date >= Date.today
        found_study_unit = StudyUnit.find_by(id: study_unit.id)
        return get_periods_by_study_unit(found_study_unit)
      end
    end
  end

  def previous_study_unit
    @group = Group.find(params[:id])
    @periods = []
    get_group_students
    group_study_units = get_group_study_units
    return if group_study_units.nil?

    group_study_units.each do |study_unit|
      if study_unit.periods.order(:commence_datetime).first.commence_datetime.to_date <= Date.today && study_unit.periods.order(:commence_datetime).last.commence_datetime.to_date >= Date.today
        if group_study_units.index(study_unit) == 0
          puts 'На данный момент не имеется предыдущего учебного блока'
        else
          group_study_units[group_study_units.index(study_unit) - 1].periods.where(group_id: @group).order(:commence_datetime).each do |period|
            @periods.push period
          end
        end
      end
    end
  end

  def get_course_groups
    course_id = params[:course_id]

    course = Course.find_by(id: course_id)
    course_groups = course.groups
    teacher_groups = current_student.groups

    groups = course_groups & teacher_groups
    groups_list = []
    groups.each do |group|
      groups_list.push({id: group.id, name: group.name})
    end

    render json: groups_list
  end

  def get_group_report_table
    @group = Group.find(params[:group_id])
    get_all_group_periods
    get_group_students
  end

  def get_group_filters
    @group = Group.find(params[:group_id])
    get_group_study_units
  end

  def get_educational_unit
    @group = Group.find(params[:id])
    @study_unit = StudyUnit.find(params[:study_unit_id])
    get_periods_by_study_unit(@study_unit)
    get_group_study_units
    get_group_students
  end

  def get_student_total_attendance
    attendance = Attendance.find_by_period_id_and_student_id(params[:period_id], params[:user_id])
    student_id = params[:user_id]
    period_id = params[:period_id]
    @group = Group.find(params[:id])
    get_all_group_periods
    get_group_students

    if attendance.attended
      attendance.update_column(:attended, false)
    else
      attendance.update_column(:attended, true)
    end

    student_quantity = Attendance.attended_periods(student_id, @periods)
    attendance_quantity = Attendance.attended_periods(@group_students, period_id)

    attended_periods = []
    attended_periods.push({user_id: student_id,
                           period_id: period_id,
                           student_quantity: student_quantity,
                           attendance_quantity: attendance_quantity
                          })

    render json: attended_periods
  end

  private

  def get_group_study_units
    @group_study_units = []
    periods = Period.where(group_id: @group)
    periods.each do |period|
      @group_study_units.push period.study_unit unless period.study_unit.nil?
    end
    @group_study_units.uniq!
  end

  def get_periods_by_study_unit(study_unit)
    @periods = []
    @periods += study_unit.periods.order(:commence_datetime).where(group_id: @group).to_a
  end

  def get_all_group_periods
    @periods = Period.order(:commence_datetime).where(group_id: @group.id)
  end

  def get_group_students
    @group_students = []
    @group.users.each do |student|
      # if student_access?(student)
        @group_students.push student
     # end
    end
    @group_students
  end

  def get_teacher_courses(teacher)
    @courses = []
    teacher.groups.each do |group|
      @courses.push group.course
    end
    @courses.uniq!
  end

end