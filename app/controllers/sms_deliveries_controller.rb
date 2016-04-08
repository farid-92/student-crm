class SmsDeliveriesController < ApplicationController
  def new
    @sms = SmsDelivery.new
  end

  def create
    @sms = SmsDelivery.new(get_sms_params)
    @sms.delivery_time = Time.now + 3.minutes
    if @sms.save
      flash[:success] = 'Рассылка будет отправлена через 3 минуты'
      send_message(@sms)
    else
      render 'new'
    end
  end

  def edit
    @sms = SmsDelivery.find(params[:id])
  end

  def update
    @sms = SmsDelivery.find(params[:id])

    # if params[:resend].blank?
      @sms.delivery_time = Time.now + 3.minutes
      if @sms.update(get_sms_params)

        flash[:success] = 'Вы успешно отредактировали рассылку'

        redirect_to sms_deliveries_url(resource_id: 1)
        return
      else
        render 'edit' and return
      end
    # else
    #   @sms.delivery_time = Time.now + 3.minutes
    #   if @sms.update(get_sms_params)
    #     flash[:danger] = 'Рассылка будет отправлена через 3 минуты'
    #
    #     send_message(@sms)
    #   else
    #     render 'edit'
    #   end
    # end
  end

  def index
    @messages = SmsDelivery.all
    @accounts = SmsServiceAccount.all
    @contact_lists = ContactList.all
    @resource = params[:resource_id]
  end

  def message_index
    @messages = SmsDelivery.all
  end

  def destroy
    @sms = SmsDelivery.find(params[:id])
    @sms.destroy
    flash[:success] = 'Вы удалили рассылку'

    redirect_to sms_deliveries_url(resource_id: 1)
  end

  def send_sms
    @sms = SmsDelivery.find(params[:id])
    @sms.update_attribute(:delivery_time, Time.now)
    flash[:danger] = 'Вы успешно отравили рассылку'
    send_message(@sms)
  end

  private

  def get_sms_params
    params.require(:sms_delivery).permit(:title, :content, :sender_id, :contact_list_id)
  end

  def send_message(object)
    path = '/api/message'
    xml_response = set_url(path, get_xml_format(object))
    response = Hash.from_xml(xml_response.body)
    case response['response']['status']
      when '0'

        redirect_to sms_deliveries_url(resource_id: 1)
      when '1'
        flash[:danger] = 'Ошибка в формате запроса'

        redirect_to sms_deliveries_url(resource_id: 1)
      when '2'
        flash[:danger] = 'Неверная авторизация'

        redirect_to sms_deliveries_url(resource_id: 1)
      when '3'
        flash[:danger] = 'Недопустимый IP‐адрес отправителя'

        redirect_to sms_deliveries_url(resource_id: 1)
      when '4'
        flash[:danger] = 'Недостаточно средств на счету'

        redirect_to sms_deliveries_url(resource_id: 1)
      when '5'
        flash[:danger] = 'Недопустимое имя отправителя'

        redirect_to sms_deliveries_url(resource_id: 1)
      when '6'
        flash[:danger] = 'Сообщение заблокировано по стоп‐словам'

        redirect_to sms_deliveries_url(resource_id: 1)
      when '7'
        flash[:danger] = ' Некорректное написание одного или нескольких номеров'

        redirect_to sms_deliveries_url(resource_id: 1)
      when '8'
        flash[:danger] = 'Неверный формат времени отправки'

        redirect_to sms_deliveries_url(resource_id: 1)
      when '9'
        flash[:danger] = 'Отправка заблокирована из‐за срабатывания SPAM фильтра.'

        redirect_to sms_deliveries_url(resource_id: 1)
      when '10'
        flash[:danger] = 'Отправка заблокирована  из‐за последовательного повторения id'

        redirect_to sms_deliveries_url(resource_id: 1)
      when '11'
        flash[:danger] = 'Сообщение успешно обработано, но не принято к отправке и не протарифицировано 
т.к. в запросе был установлен параметр <test>1</test>'

        redirect_to sms_deliveries_url(resource_id: 1)
      else
        flash[:danger] = 'Ошибка отправки'

        redirect_to sms_deliveries_url(resource_id: 1)
    end

  end

  def get_xml_format(object)
    rand_string = (0...50).map { ('a'..'z').to_a[rand(26)] }.join

    Nokogiri::XML::Builder.new do |xml|
      xml.message {
        xml.login(object.sender.sms_service_account.login)
        xml.pwd(object.sender.sms_service_account.password)
        xml.id(rand_string)
        xml.sender(object.sender.name)
        xml.text_ object.content
        xml.time object.delivery_time.strftime('%Y%m%d%H%M%S')
        xml.phones {

          object.contact_list.users.each do |user|
            xml.phone(user.first_phone)
          end

        }
      }
    end
  end

  def set_url (path, message)
    http = Net::HTTP.new('smspro.nikita.kg')
    http.post(path, message.to_xml)
  end

  def build_report(object)
    rand_string = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    Nokogiri::XML::Builder.new do |xml|
      xml.dr {
        xml.login(object.sender.sms_service_account.login)
        xml.pwd(object.sender.sms_service_account.password)
        xml.id(rand_string)
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


end
