module SmsHandler
  extend ActiveSupport::Concern

  def send_message
    url = '/api/message'
    @response = set_url(url, build_message)
    update_attribute(:status, true)
  end

  def build_message
    phone_numbers = get_phones

    Nokogiri::XML::Builder.new do |xml|
      xml.message {
        xml.login(sender.sms_service_account.login)
        xml.pwd(sender.sms_service_account.password)
        xml.id(set_message_id(Time.now))
        xml.sender(sender.name)
        xml.text_ content
        xml.phones {
          phone_numbers.each do |phone|
            xml.phone(phone)
          end
        }
      }
    end
  end

  def build_report
    Nokogiri::XML::Builder.new do |xml|
      xml.dr {
        xml.login(sender.sms_service_account.login)
        xml.pwd(sender.sms_service_account.password)
        xml.id(set_message_id(delivery_time))
      }
    end
  end

  def parse_report(xml)
    xml_doc = Nokogiri::XML(xml.body)
    xml_doc.remove_namespaces!
    doc = xml_doc.xpath('//phone')
    hash = {}
    doc.each do |phone|
      hash[phone.xpath('number').text] = phone.xpath('report').text
    end
    hash
  end
  

  private

  def set_url (url, message)
    http = Net::HTTP.new('smspro.nikita.kg')
    http.post(url, message.to_xml)
  end

  def set_message_id(time)
    time = time.to_formatted_s(:number)
    time.slice!(0..1)
    time
  end

  def fill_title
    if self.title.blank?
      self.title = self.content[0, 69]
    end
  end

  def get_phones
    phones = []
    # if group_list = Group.find_by(name:contact_list.title)
    #   group_list.users.each do |user|
    #     phones.push user.phone
    #   end
    #   return phones
    if contact_list.custom_lists.any?
      contact_list.custom_lists.each do |phone|
        phones.push phone.phone
      end
      return phones
    else
      contact_list.users.each do |student|
        if student.active?
          phones.push student.first_phone
        end
        # puts student.phone
      end
      return phones
    end
  end

end