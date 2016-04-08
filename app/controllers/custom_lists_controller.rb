class CustomListsController < ApplicationController
  def import
    contact_list = CustomList.import(params[:file])
    render json: {:id => contact_list.id, :title => contact_list.title}
  end
end
