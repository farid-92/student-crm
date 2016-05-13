class GroupsController < ApplicationController
  def new
    @group = Group.new
    @course = Course.find(params[:course_id])
  end

  def create
    @group = Group.new(get_group_params)
    if @group.save
      flash[:success] = 'Вы успешно создали группу'

      redirect_to show_course_index_path(@group.course, resource: 2)
    else
      @course = @group.course
      render action: 'new'
    end
  end

  def edit
    @group = Group.find(params[:id])
    @course = Course.find(params[:course_id])
  end

  def update
    @group = Group.find(params[:id])

    if @group.update(get_group_params)
      flash[:success] = 'Вы успешно отредактировали группу'

      redirect_to show_course_index_path(@group.course, resource: 2)
    else
      @course = @group.course
      render action: 'edit'
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:danger] = 'Вы удалили группу'

    redirect_to show_course_index_path(@group.course, resource: 2)
  end

  private

  def get_group_params
    params.require(:group).permit(:name, :group_short_name, :course_id, :starts_at, :ends_at)
  end

end
