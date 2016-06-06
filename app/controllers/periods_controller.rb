class PeriodsController < ApplicationController

  def new
    @period = Period.new
    @group = Group.find(params[:group_id])
  end

  def create
    @period = Period.new(get_period_params)
    @group = Group.find(params[:period][:group_id])
    @period.group_id = @group.id
    @period.course_id = @group.course.id
    if params[:period][:commence_datetime].present?
      group_periods = Period.where(group_id: @group.id)
      current_period_datetime = Date.parse(params[:period][:commence_datetime])
      group_periods.each do |period|
        if period.commence_datetime.to_date == current_period_datetime.to_date
          flash.now[:danger] = 'На указанную дату уже создано занятие'
          render 'new'
          return
        end
      end
      get_period_lesson_number
    end

    if @period.save
      save_to_period_dependencies
      flash[:success] = 'Вы успешно создали занятие'

      redirect_to show_group_index_url(@group, resource: 2)
    else
      render 'new'
    end
  end

  def show
    @period = Period.find(params[:id])
    @group = Group.find(@period.group)
  end

  def show_material
    @material = CourseElementMaterial.find(params[:id])
    @period = Period.find(params[:period_id])
  end

  def edit
    @period = Period.find(params[:id])
    @group = Group.find(params[:group_id])
  end

  def update
    @period = Period.find(params[:id])
    @group = Group.find(params[:period][:group_id])
    group_periods = Period.where(group_id: @group.id).order(:lesson_number)
    current_period_datetime = Date.parse(params[:period][:commence_datetime])
    if current_period_datetime.present?
      group_periods.each do |period|
        unless @period.commence_datetime.to_date == current_period_datetime.to_date
          if period.commence_datetime.to_date == current_period_datetime.to_date
            flash.now[:danger] = 'На указанную дату уже создано занятие'
            render 'edit' and return
          end
        end
      end
    end

    prev_commence_datetime = @period.commence_datetime.to_date
    prev_lesson_number = @period.lesson_number.to_i

    if @period.update(get_period_params)
      update_periods_order(group_periods, current_period_datetime, prev_commence_datetime, prev_lesson_number)

      flash[:success] = 'Вы успешно отредактировали занятие'

      redirect_to show_group_index_url(@group, resource: 2)
    else
      render action: 'edit'
    end
  end

  def destroy
    @period = Period.find(params[:id])
    group = @period.group
    upcoming_periods = []
    current_period_datetime = Date.parse(params[:commence_datetime])
    group.periods.each do |period|
      upcoming_periods.push period if period.commence_datetime.to_date > current_period_datetime.to_date
    end
    upcoming_periods.each {|period| period.update_attribute(:lesson_number, period.lesson_number.to_i - 1) } if upcoming_periods.present?
    @period.destroy
    flash[:danger] = 'Вы удалили занятие'

    redirect_to show_group_index_path(group, resource: 2)
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
    group_id = params[:period][:group_id]
    group = Group.find(group_id)
    if group.users.exists?
      save_to_dependencies(group)
    end
  end

  def get_period_lesson_number
    current_period_datetime = Date.parse(params[:period][:commence_datetime])
    group_periods = Period.where(group_id: @group.id).order(:commence_datetime)
    previous_periods = []
    upcoming_periods = []
    if group_periods.empty?
      @period.lesson_number = 1
    else
      get_past_and_coming_periods(group_periods, current_period_datetime, previous_periods, upcoming_periods)

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
        if prev_commence_datetime.to_date < current_period_datetime.to_date
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
      if period.commence_datetime.to_date < current_period_datetime.to_date
        previous_periods.push period
      elsif period.commence_datetime.to_date > current_period_datetime.to_date
        upcoming_periods.push period
      end
    end
    previous_periods.sort! { |a, b|  a.commence_datetime.to_date <=> b.commence_datetime.to_date }
    upcoming_periods.sort! { |a, b|  a.commence_datetime.to_date <=> b.commence_datetime.to_date }
  end



end
