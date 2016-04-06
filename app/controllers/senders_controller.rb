class SendersController < ApplicationController
  def new
    @sender = Sender.new
  end

  def create
    @sender = Sender.new(get_sender_params)
    if @sender.save
      flash[:success] = 'Вы успешно создали отправителя'

      redirect_to sms_deliveries_url(resource_id: 3)
    else
      render 'new'
    end
  end

  def edit
    @sender = Sender.find(params[:id])
  end

  def update
    @sender = Sender.find(params[:id])
    if @sender.update(get_sender_params)
      flash[:success] = 'Вы успешно отредактировали отправителя'

      redirect_to sms_deliveries_url(resource_id: 3)
    else
      render 'edit'
    end
  end

  def index
    @accounts = SmsServiceAccount.all
  end

  def destroy
    @sender = Sender.find(params[:id])
    @sender.destroy
    flash[:danger] = 'Вы успешно удалили отправителя'

    redirect_to sms_deliveries_url(resource_id: 3)
  end

  private

  def get_sender_params
    params.require(:sender).permit(:name, :sms_service_account_id)
  end

end
