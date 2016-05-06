namespace :sms do
  desc 'Rake task to send sms message'

  task :send => :environment do
    SmsDelivery.where(status:false).each do |message|

      if message.delivery_time <= Time.now
        message.send_message
      end

    end
  end

  # task :smart => :environment do
  #
  #   today = DateTime.now.strftime('%B %d, %Y')
  #
  #   smart_message = SmsDelivery.where(smart_delivery: true).first
  #
  #   new_message = smart_message.dup
  #   new_message.update_attribute(:smart_delivery, false)
  #   new_message.update_attribute(:delivery_time, Time.now)
  #   Period.all.each do |period|
  #
  #     if today == period.commence_datetime.strftime('%B %d, %Y')
  #       puts 'i made it to IF, i am good'
  #       new_message.content = smart_message.content % {курс: period.course.name,
  #                                                      тип_занятия: period.event_type.capitalize,
  #                                                      номер_занятия: period.lesson_number,
  #                                                      дата: period.commence_datetime.strftime('%Y-%m-%d'),
  #                                                      время: period.commence_datetime.strftime('%H:%M'),
  #                                                      тема: period.course_element.theme}
  #       new_message.send_message
  #     end
  #     puts 'I am not working.'
  #   end
  # end

end