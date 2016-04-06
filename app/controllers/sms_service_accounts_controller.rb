class SmsServiceAccountsController < ApplicationController

  def new
    @account = SmsServiceAccount.new
  end

  def create
    @account = SmsServiceAccount.new(account_params)
    @account.user_id = current_user.id
    if @account.save
      flash[:success] = 'Вы успешно добавили аккаунт'

      redirect_to sms_service_accounts_path
    else
      render 'new'
    end
  end

  def index
    @accounts = SmsServiceAccount.all
  end

  def edit
    @account = SmsServiceAccount.find(params[:id])
  end

  def update
    @account = SmsServiceAccount.find(params[:id])
    if @account.update(account_params)
      flash[:success] = 'Вы успешно отредактировали акакунт'

      redirect_to sms_service_accounts_url
    else
      render 'edit'
    end
  end

  def destroy
    @account = SmsServiceAccount.find(params[:id])
    @account.destroy
    flash[:danger] = 'Вы успешно удалили логин'

    redirect_to :back
  end

  private

  def account_params
    params.require(:sms_service_account).permit(:login, :password, :user_id)
  end

end
