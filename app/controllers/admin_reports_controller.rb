class AdminReportsController < ApplicationController
  def index
    @courses = Course.all
  end

  # def get_course_groups
  #   course_id = params[:course_id]
  #
  #   course = Course.find_by(id: course_id)
  #   course_groups = course.groups
  #
  #   groups_list = []
  #   course_groups.each do |group|
  #     groups_list.push({id: group.id, name: group.name})
  #   end
  #
  #   render json: groups_list
  # end

  def attendance_current_study_unit
    current_study_unit
    render_admin_attendance_table
  end

  def homework_current_study_unit
    current_study_unit
    render_admin_homework_table
  end

  def attendance_previous_study_unit
    previous_study_unit
    render_admin_attendance_table
  end

  def homework_previous_study_unit
    previous_study_unit
    render_admin_homework_table
  end

  def attendance_report_table
    get_group_report_table
    render_admin_attendance_table
  end

  def homework_report_table
    get_group_report_table
    render_admin_homework_table
  end

  def admin_reports_filters
    get_group_filters
    render partial: 'admin_reports/admin_reports_filters'
  end

  def attendance_educational_unit
    get_educational_unit
    render_admin_attendance_table
  end

  def homework_educational_unit
    get_educational_unit
    render_admin_homework_table
  end

  private

  def render_admin_attendance_table
    render partial: 'admin_reports/admin_attendances_table'
  end

  def render_admin_homework_table
    render partial: 'shared/homeworks_table'
  end

end
