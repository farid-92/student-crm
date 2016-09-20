class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Report

  def save_to_dependencies_of_group(group)
    group.periods.each do |group_period|
      group.users.each do |group_student|
        Homework.skip_callback(:save, :before, :set_file_name)
        ExtraHomework.skip_callback(:save, :before, :set_file_name)
        attendances = Attendance.where(period_id: group_period.id, user_id: group_student.id)
        homeworks = Homework.where(period_id: group_period.id, user_id: group_student.id)
        if attendances.blank?
          attendance = Attendance.new(period_id: group_period.id, user_id: group_student.id, attended: false)
          attendance.save
        end

        if homeworks.blank?
          homework = Homework.new(
              period_id: group_period.id,
              user_id: group_student.id,
              course_id: group.course.id,
              group_id: group.id,
              score: '0',
              feedback: '',
              teacher_id: false
          )
          homework.save(validate: false)
          extra_homework = ExtraHomework.new(
              period_id: group_period.id,
              user_id: group_student.id,
              course_id: group.course.id,
              homework_id: homework.id,
              group_id: group.id,
              feedback: '',
              teacher_id: false,
              download_status: false
          )
          extra_homework.save(validate: false)
        end
      end
    end
  end


end
