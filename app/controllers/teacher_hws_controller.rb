class TeacherHwsController < ApplicationController

  def students_index
    @period = Period.find(params[:period_id])
    @group = Group.find(params[:group_id])
  end

  def students_index_date
    @period = Period.find(params[:period_id])
    @group_id = params[:group_id]
    @group = Group.find(params[:group_id])
  end

end
