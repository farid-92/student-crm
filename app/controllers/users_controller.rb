class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    $file = params[:user][:passport_photo]
    @user = User.new(user_params)
    generated_password = Devise.friendly_token.first(8)
    @user.password = generated_password
    @user.password_txt = generated_password
    group_ids = params[:user][:group_ids]
    group_ids.shift
    if group_ids.blank?
      flash[:danger] = 'Выберите группу для студента'
      render 'new' and return
    end
    course_ids = []
    group_ids.each do |group_id|
      course_ids.push Group.find(group_id).course.id
    end
    role_ids = params[:user][:role_ids]
    role_ids.shift
    role_ids.each do |role_id|
      user_role = Role.find(role_id)
      if user_role.name == 'student'
        if course_ids.uniq.length != course_ids.length
          flash.now[:danger] = 'Студент не может быть одновременно в двух группах одного курса'
          render 'new' and return
        end
      end
    end

    if @user.save
      save_to_student_dependencies(group_ids)
      flash[:notice] = 'Студент успешно добавлен'
     # UserMailer.password_email(@user, generated_password).deliver_now

      redirect_to root_path(resource_id: 2)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    @group = Group.find(params[:group_id]) unless params[:group_id].nil?
  end

  def update
    $file = params[:user][:passport_photo]
    @user = User.find(params[:id])
    unless params[:user][:group_id].nil?
      @group = Group.find(params[:user][:group_id])
    end

    group_ids = params[:user][:group_ids]
    group_ids.shift
    if group_ids.blank?
      flash[:danger] = 'Выберите группу для студента'
      render 'edit'
      return
    end
    course_ids = []
    group_ids.each do |group_id|
      course_ids.push Group.find(group_id).course.id
    end
    if course_ids.uniq.length == course_ids.length
      if @user.update(user_params)
        save_to_student_dependencies(group_ids)
        flash[:notice] = 'Данные успешно отредактированы!'
        redirect_to root_path(resource_id: 2)
      else
        render 'edit'
      end
    else
      flash.now[:danger] = 'Студент не может быть одновременно в двух группах одного курса'
      render 'edit'
    end

  end

  def show
    @user = User.find(params[:id])
    @user_groups = @user.groups
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path(resource_id: 2)
  end

  def download_passport
    user = User.find(params[:id])
    send_file(user.passport_photo.path)
  end

  def generate_contract
    @user = User.find(params[:id])
    @group = Group.find(params[:group_id])
    contract_pdf = ContractPdf.new(@user, @group)

    send_data contract_pdf.render,
              filename: "#{@user.surname} #{@user.name}.pdf",
              type: 'application/pdf',
              disposition: 'inline'
  end


  def changestatus
    user = User.find(params[:id])
    user.update_attribute(:active, !user.active)
    redirect_to root_path(resource_id: 2)
  end

  def set_user_role
    choose_role(params[:role])
  end

  private

  def user_params
    params.require(:user).permit(
        :name,
        :surname,
        :gender,
        :birthdate,
        :first_phone,
        :second_phone,
        :skype,
        :passport_id,
        :email,
        :issue_date,
        :issued_by,
        :passport_inn,
        :photo,
        :passport_photo,
        :group_ids => [],
        :role_ids => []
    )
  end

  def save_to_student_dependencies(group_ids)
    group_ids.each do |group_id|
      group = Group.find(group_id)
      if group.periods.exists?
        save_to_dependencies_of_group(group)
      else
        break
      end
    end
  end



end
