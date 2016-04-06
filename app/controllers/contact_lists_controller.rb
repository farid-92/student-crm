class ContactListsController < ApplicationController

  def new
    @contact_list = ContactList.new
  end

  def create
    @contact_list = ContactList.new(get_contact_list_params)
    if @contact_list.save
      flash[:success] = 'Вы успешно создали лист получателей'

      redirect_to sms_deliveries_url(resource_id: '2')
    else
      render 'new'
    end
  end

  def index
    @contact_lists = ContactList.all
  end

  def edit
    @contact_list = ContactList.find(params[:id])
  end

  def update
    @contact_list = ContactList.find(params[:id])
    if @contact_list.update(get_contact_list_params)
      flash[:success] = 'Вы успешно отредактировали получателей'

      redirect_to sms_deliveries_url(resource_id: '2')
    else
      render 'edit'
    end

  end

  def destroy
    @contact_list = ContactList.find(params[:id])
    @contact_list.destroy
    flash[:danger] = 'Вы успешно удалили лист получателей'

    redirect_to sms_deliveries_url(resource_id: '2')
  end

  private

  def get_contact_list_params
    params.require(:contact_list).permit(:title, :users_ids => [])
  end
end
