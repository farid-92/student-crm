class CalendarController < ApplicationController

  include CalendarHelper

  def fullcalendar
    @period = Period.new
  end

  def fullcalendar_for_student
  end

  def new_period_from_calendar
    @period = Period.new
    @course = Course.find(params[:course_id])
  end

  def create_period_from_calendar
    @period = Period.new(get_period_params)
    @course = Course.find(params[:period][:course_id])
    if params[:period][:commence_datetime].present?
      course_periods = Period.where(course_id: @course.id)
      current_period_datetime = Date.parse(params[:period][:commence_datetime])
      course_periods.each do |period|
        if period.commence_datetime == current_period_datetime.to_date
          flash.now[:danger] = 'На указанную дату уже создано занятие'
          render 'fullcalendar'
          return
        end
      end
      get_period_lesson_number
    end

    if @period.save
      save_to_period_dependencies
      flash[:success] = 'Вы успешно создали занятие'

      redirect_to calendar_fullcalendar_path
    else
      render 'fullcalendar'
    end
  end

  def edit_period_from_calendar
    @period= Period.find(params[:id])
    @course = @period.course
    render template: 'calendar/edit_period_from_calendar', layout: false
  end

  def update_period_from_calendar
    @period = Period.find(params[:id])
    @course = Course.find(params[:period][:course_id])
    course_periods = Period.where(course_id: @course.id).order(:lesson_number)
    current_period_datetime = Date.parse(params[:period][:commence_datetime])
    if current_period_datetime.present?
      course_periods.each do |period|
        unless @period.commence_datetime.to_date == current_period_datetime.to_date
          if period.commence_datetime.to_date == current_period_datetime.to_date
            flash.now[:danger] = 'На указанную дату уже создано занятие'
            render 'edit_period_from_calendar'
            return
          end
        end
      end
    end

    prev_commence_datetime = @period.commence_datetime
    prev_lesson_number = @period.lesson_number.to_i

    if @period.update(get_period_params)
      update_periods_order(course_periods, current_period_datetime, prev_commence_datetime, prev_lesson_number)
      flash[:success] = 'Вы успешно отредактировали занятие'

      redirect_to calendar_fullcalendar_path
    else
      render action: 'edit_period_from_calendar'
    end
  end

  def destroy_period_from_calendar
    @period = Period.find(params[:id])
    course = @period.course
    upcoming_periods = []
    current_period_datetime = @period.commence_datetime
    course.periods.each do |period|
      upcoming_periods.push period if period.commence_datetime.to_date > current_period_datetime.to_date
    end
    upcoming_periods.each {|period| period.update_attribute(:lesson_number, period.lesson_number.to_i - 1) } if upcoming_periods.present?
    @period.destroy
    flash[:danger] = "Вы успешно удалили занятие №#{@period.lesson_number} - #{@period.title}"

    redirect_to calendar_fullcalendar_path
  end

  def group_of_course_new_period
    groups_list = []
    Group.where(course_id: params[:course_id]).each do |group|
      groups_list.push({id: group.id, name: group.name})
    end
    render json: groups_list
  end

  def course_element_of_course_new_period
    course_elements_list = []
    CourseElement.where(course_id: params[:course_id]).each do |course_element|
      course_elements_list.push ({id: course_element.id, theme: course_element.theme})
    end
    render json: course_elements_list
  end

  def get_period_for_popup
    @popup_period = Period.find(params[:period_id])
    render template: 'calendar/get_period_for_popup', layout: false
  end

  def get_event_for_popup
    @event_popup = Event.find(params[:event_id])
    render template: 'calendar/get_calendar_event_for_popup', layout: false
  end

  def groups_of_courses
    @groups = Group.where(course_id: params[:course_id])
    render template: 'calendar/groups_of_courses', :layout => false
  end

  def teachers_of_courses
    @groups_array = []
    Group.where(course_id: params[:course_id]).each do |group|
      @groups_array.push group.id
    end
    render template: 'calendar/teachers_of_courses', layout: false
  end

  def teacher_of_group
    @groups_array = []
    Group.where(id: params[:group_id]).each do |group|
      @groups_array.push group
    end
    render template: 'calendar/teachers_of_courses', layout: false
  end

  def filter_periods_by_course
    @periods = Period.where(course_id: params[:course_id])
    create_events_for_calendar
  end

  def filter_periods_by_group
    @periods = Period.where(group_id: params[:group_id])
    create_events_for_calendar
  end

  def filter_periods_by_teachers
    group_ids = []
    @group_memberships = GroupMembership.where(user_id: params[:teacher_id]).each do |group_membership|
      group_ids.push group_membership.group_id
    end
    @periods = Period.where(group_id: group_ids)
    create_events_for_calendar
  end

  def get_periods_events_in_json_format
    # current_user.admissions.each do |admission|
    #   if admission.role.access == 'teacher' || admission.role.access == 'teacher_redactor'
    #     student_groups = []
    #     GroupMembership.where(user_id: current_user.id).each do |group_membership|
    #       student_groups.push group_membership.group_id
    #     end
    #     @periods = Period.where(group_id: student_groups)
    #   elsif admission.role.access == 'admin'
        @periods = Period.all
    #  end
    # end
    create_events_for_calendar
  end

  def periods_json_for_students
    student_groups = []
    GroupMembership.where(user_id: current_user.id).each do |group_membership|
      student_groups.push group_membership.group_id
    end
    @periods = Period.where(group_id: student_groups)
    create_events_for_calendar
  end

  private

  def get_period_params
    params.require(:period).permit(:title,
                                   :commence_datetime,
                                   :lesson_number,
                                   :course_id,
                                   :group_id,
                                   :start_time,
                                   :end_time,
                                   :course_element_id
    )
  end

  def save_to_period_dependencies
    course_id = params[:period][:course_id]
    course = Course.find(course_id)
    if course.groups.exists?
      course.groups.each do |group|
        if group.users.exists?
          save_to_dependencies(course)
        else
          next
        end
      end
    end
  end

  def get_period_lesson_number
    current_period_datetime = Date.parse(params[:period][:commence_datetime])
    course_periods = Period.where(course_id: @course.id).order(:commence_datetime)
    previous_periods = []
    upcoming_periods = []
    if course_periods.empty?
      @period.lesson_number = 1
    else
      get_past_and_coming_periods(course_periods, current_period_datetime, previous_periods, upcoming_periods)

      update_upcoming_periods(previous_periods, upcoming_periods)

      if upcoming_periods.blank? && previous_periods.present?
        @period.lesson_number = previous_periods.last.lesson_number.to_i + 1
      end

      if upcoming_periods.present? && previous_periods.present?
        @period.lesson_number = previous_periods.last.lesson_number.to_i + 1
        upcoming_periods.each do |period|
          period.update_attribute(:lesson_number, period.lesson_number.to_i + 1)
        end
      end
    end
  end

  def update_periods_order(course_periods, current_period_datetime, prev_commence_datetime, prev_lesson_number)
    previous_periods = []
    upcoming_periods = []

    unless prev_commence_datetime.to_date == current_period_datetime.to_date
      get_past_and_coming_periods(course_periods, current_period_datetime, previous_periods, upcoming_periods)

      if upcoming_periods.present? && previous_periods.blank?
        @period.update_attribute(:lesson_number, upcoming_periods.first.lesson_number)
        upcoming_periods.each do |period|
          period.update_attribute(:lesson_number, period.lesson_number.to_i + 1) if period.lesson_number.to_i < prev_lesson_number
        end
      end

      if upcoming_periods.blank? && previous_periods.present?
        @period.update_attribute(:lesson_number, previous_periods.last.lesson_number.to_i)
        previous_periods.each do |period|
          period.update_attribute(:lesson_number, period.lesson_number.to_i - 1) unless period.lesson_number.to_i <= prev_lesson_number
        end
      end

      if upcoming_periods.present? && previous_periods.present?
        if prev_commence_datetime < current_period_datetime
          @period.update_attribute(:lesson_number, previous_periods.last.lesson_number.to_i)
          previous_periods.reverse!
          previous_periods.each do |period|
            break if period.lesson_number.to_i == prev_lesson_number
            period.update_attribute(:lesson_number, period.lesson_number.to_i - 1)
          end
        else
          @period.update_attribute(:lesson_number, previous_periods.last.lesson_number.to_i + 1)
          upcoming_periods.each do |period|
            break if period.lesson_number.to_i == prev_lesson_number
            period.update_attribute(:lesson_number, period.lesson_number.to_i + 1)
          end
        end
      end
    end
  end

  def update_upcoming_periods(previous_periods, upcoming_periods)
    if upcoming_periods.present? && previous_periods.blank?
      @period.update_attribute(:lesson_number, 1)
      upcoming_periods.each do |period|
        period.update_attribute(:lesson_number, period.lesson_number.to_i + 1)
      end
    end
  end

  def get_past_and_coming_periods(course_periods, current_period_datetime, previous_periods, upcoming_periods)
    course_periods.each do |period|
      if period.commence_datetime.to_date < current_period_datetime
        previous_periods.push period
      elsif period.commence_datetime.to_date > current_period_datetime
        upcoming_periods.push period
      end
    end
    previous_periods.sort! { |a, b|  a.commence_datetime.to_date <=> b.commence_datetime.to_date }
    upcoming_periods.sort! { |a, b|  a.commence_datetime.to_date <=> b.commence_datetime.to_date }
  end

end
