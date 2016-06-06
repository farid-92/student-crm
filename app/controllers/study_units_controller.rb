class StudyUnitsController < ApplicationController

  def new
    @study_unit = StudyUnit.new
    @group = Group.find(params[:group_id])
  end

  def create
    @group = Group.find(params[:study_unit][:group_id])
    @study_unit = StudyUnit.new(get_study_unit_params)
    @study_unit.group_id = @group.id
    if @study_unit.save
      flash[:success] = 'Вы успешно создали учебный блок'

      redirect_to show_group_index_path(@group, resource: 3)
    else
      render action: 'new'
    end
  end

  def edit
    @study_unit = StudyUnit.find(params[:id])
    @group = Group.find(params[:group_id])
  end

  def update
    @study_unit = StudyUnit.find(params[:id])
    @group = Group.find(params[:study_unit][:group_id])
    @study_unit.group_id = @group.id
    if @study_unit.update(get_study_unit_params)
      flash[:success] = 'Вы успешно отредактировали учебный блок'

      redirect_to show_group_index_path(@group, resource: 3)
    else
      render action: 'edit'
    end
  end

  def destroy
    @group = Group.find(params[:group_id])
    @study_unit = StudyUnit.find(params[:id])
    @study_unit.destroy
    flash[:danger] = 'Вы удалили учебный блок'

    redirect_to show_group_index_path(@group, resource: 3)
  end

  private

  def get_study_unit_params
    params.require(:study_unit).permit(:unit, :group_id, :period_ids => [])
  end

end
