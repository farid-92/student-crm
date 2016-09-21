class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Report
  helper_method :current_controller?, :current_action?

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { render nothing: true, status: :forbidden }
      format.html { redirect_to :back, :alert => exception.message }
    end
  end

  def after_sign_in_path_for(resource)
    set_default_role
    root_path
  end

  # Выбираем роль по умолчанию при логине. Роль с большими полномочиями имеет больший вес
  def set_default_role
    if current_user.has_any_role? :admin
      choose_role(:admin)
    elsif current_user.has_any_role? :manager
      choose_role(:manager)
    elsif current_user.has_any_role? :teacher
      choose_role(:teacher)
    elsif current_user.has_any_role? :techsupport
      choose_role(:techsupport)
    elsif current_user.has_any_role? :student
      choose_role(:student)
    end
  end

  # Пользователь выбирает роль, под которой будет работать в системе
  def choose_role(role)
    session[:current_user_role] = role
  end

  # Используем для проверки во вьшках
  def current_controller?(names)
    names.include?(params[:controller]) unless params[:controller].blank? || false
  end

  def current_action?(names)
    names.include?(params[:action]) unless params[:action].blank? || false
  end



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
