module CalendarHelper

  def create_events_for_calendar
    events = []
    if @periods.nil?
    else
      @periods.each do |period|
        events.push({
                        lesson_number: period.lesson_number,
                        title: "№#{period.lesson_number}. #{period.title}",
                        theme: period.title,
                        start: period.commence_datetime.strftime('%F ') + period.start_time.strftime('%H:%M'),
                        end: period.commence_datetime.strftime('%F ') + period.end_time.strftime('%H:%M'),
                        id: period.id
                    })
      end
    end

    @events = Event.all
    if @events.nil?
    else
      @events.each do |calendar_event|
        events.push({
                        title: calendar_event.title,
                        start: calendar_event.start_date,
                        end: calendar_event.end_date,
                        id: calendar_event.id,
                        backgroundColor: 'lightblue',
                        attribute: 'calendar_event'
                    })
      end
    end

    render json: events
  end

  def save_to_dependencies(course)
    course_periods = []
    course.course_elements.each do |element|
      course_periods += element.periods.to_a
    end
    course.groups.each do |course_group|
      group_students = []
      group_students += course_group.users.to_a
      course_periods.each do |course_period|
        group_students.each do |course_student|
          Homework.skip_callback(:save, :before, :set_file_name)
          ExtraHomework.skip_callback(:save, :before, :set_file_name)
          attendances = Attendance.where(period_id: course_period.id, user_id: course_student.id)
          homeworks = Homework.where(period_id: course_period.id, user_id: course_student.id)

          if attendances.blank?
            attendance = Attendance.new(period_id: course_period.id, user_id: course_student.id)
            attendance.save
          end

          if homeworks.blank?
            homework = Homework.new(
                period_id: course_period.id,
                user_id: course_student.id,
                course_id: course.id,
                group_id: course_group.id,
                score: '0',
                feedback: '',
                teacher_id: false
            )
            homework.save(validate: false)
            extra_homework = ExtraHomework.new(
                period_id: course_period.id,
                user_id: course_student.id,
                course_id: course.id,
                homework_id: homework.id,
                group_id: course_group.id,
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

end
