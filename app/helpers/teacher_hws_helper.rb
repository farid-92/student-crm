module TeacherHwsHelper

  def show_deadline
    @period.homeworks.where(period_id: @period.id).each do |homework|
      if homework.deadline.nil?
        return "нет срока сдачи"
      else
        date = homework.deadline.strftime('%d.%m.%Y')
        return "Крайний срок сдачи: #{date}"
      end
    end
  end

end
