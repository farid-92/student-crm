class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    generated_password = Devise.friendly_token.first(8)
    @user.password = generated_password
    group_ids = params[:user][:group_ids]
    group_ids.shift
    if group_ids.blank?
      flash[:danger] = 'Выберите группу для студента'
      render 'new' and return
    end
    if @user.save
      group_ids.each do |group_id|
        GroupMembership.create!(group_id: group_id, user_id: @user.id, active: true)
      end
      # save_to_student_dependencies(group_ids)
      flash[:notice] = 'Студент успешно добавлен'
     # UserMailer.password_email(@user, generated_password).deliver_now

      redirect_to users_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
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
        group_ids.each do |group_id|
          GroupMembership.create!(group_id: group_id, user_id: @user.id, active: true)
        end
        flash[:notice] = 'Данные успешно отредактированы!'
        redirect_to users_path
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

    @group = 'RoR-группа 1'
    @course = 'Ruby on Rails'
    @practical_time = 500
    @theoretical_time = 780
    @educational_cost = 135000
    respond_to do |format|
      format.html
      format.pdf do
        pdf = ContractPdf.new(@user, view_context, @course, @practical_time, @theoretical_time, @educational_cost)
        send_data pdf.render, filename:
            "договор #{@user.created_at.strftime("%d.%m.%Y")}.pdf",
                  type: "application/pdf", disposition: "inline"
      end
    end

  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  def download_passport
    user = User.find(params[:id])
    send_file(user.passport_photo.path)
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
    )
  end

  def save_to_student_dependencies(group_ids)
    group_ids.each do |group_id|
      group = Group.find(group_id)
      if group.periods.exists?
        save_to_dependencies(group)
      else
        break
      end
    end
  end


end
