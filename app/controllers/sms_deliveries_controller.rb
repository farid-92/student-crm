class SmsDeliveriesController < ApplicationController
  def new
    @sms = SmsDelivery.new
  end

  def create
    @sms = SmsDelivery.new(get_sms_params)
    if @sms.delivery_time.nil?
      @sms.delivery_time = Time.now + 3.minutes
      flash[:success] = 'СМС рассылка будет отправлена через 3 минуты'
    else
      flash[:success] = "СМС рассылка будет отправлена  #{@sms.delivery_time.strftime('%d-%m-%Y в %H:%M ')}"
    end
    if @sms.save
      redirect_to sms_deliveries_url(resource_id: 1)
    else
      flash[:danger] = 'Вы ввели некорректные данные, проверьте и попробуйте снова'
      render 'new'
    end
  end

  def edit
    @sms = SmsDelivery.find(params[:id])
  end
  def update
    @sms = SmsDelivery.find(params[:id])
    if @sms.update(get_sms_params)
      redirect_to sms_deliveries_url(resource_id: 1)
      flash[:success] = 'Сообщение успешно отредактировано'
    else
      flash[:danger] = 'Вы ввели некорректные данные, проверьте и попробуйте снова'
      render 'edit'
    end
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
    @sms.send_message
    flash[:success] = 'Вы успешно отравили рассылку'
    redirect_to sms_deliveries_url(resource_id: 1)
  end

  def resend_message
    @sms = SmsDelivery.find(params[:id])
    @sms = SmsDelivery.new(@sms.attributes)
    render :new
  end


  private

  def get_sms_params
    params.require(:sms_delivery).permit(:title, :content, :sender_id, :contact_list_id, :delivery_time)
  end

end
