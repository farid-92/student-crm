class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    generated_password = '12345678'
    @user.password = generated_password
    if @user.save
      flash[:notice] = 'Студент успешно добавлен'
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

    if @user.update(user_params)
      redirect_to users_path
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])

  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
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


end
