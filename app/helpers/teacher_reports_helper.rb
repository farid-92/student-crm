module TeacherReportsHelper
  def attended?(period_id, student_id)
    attendance = Attendance.find_by_period_id_and_user_id(period_id, student_id)
    if attendance.attended
      true
    else
      false
    end
  end

  def show_student_total_attendance(student_id)
    periods = []

    student = User.find(student_id)
    periods += student.periods.to_a

    Attendance.attended_periods(student_id, periods)
  end

  def show_period_attendance(students, period)
    Attendance.attended_periods(students, period)
  end

  def show_next_period(periods, selected_period)
    sorted_periods = periods.sort_by do |period|
      period.commence_datetime
    end

    future_periods = []
    sorted_periods.each do |period|
      future_periods.push period if period.commence_datetime.strftime('%d.%m.%Y').to_date > Date.today
    end

    'info' if future_periods[0] == selected_period
  end

  def show_disabled_toggle(period)
    'disabled' if period.commence_datetime.strftime('%d.%m.%Y').to_date > Date.today
  end

  def show_homework_stats(object)
    student_hw = []
    sent_hw = []
    checked_hw = []
    get_students_array(object, student_hw)
    get_stats(checked_hw, sent_hw, student_hw)
  end

  def get_students_array(object, object_array)
    object.homeworks.where(group_id: @group).each do |homework|
      # homework.student.admissions.each do |admission|
      #   if admission.role.access == 'student'
          object_array.push homework
        # end
      # end
    end
  end

  def get_stats(checked_hw, sent_hw, object_array)
    object_array.each do |homework|
      sent_hw.push homework if homework.score.to_i > 0
      checked_hw.push homework if homework.score.to_i > 1
    end
    "#{sent_hw.count}/#{checked_hw.count}"
  end

end
