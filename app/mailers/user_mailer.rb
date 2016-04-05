class UserMailer < ApplicationMailer
  default from: 'esdp20155@gmail.com'

  def password_email(user, password)
    @user = user
    @generated_password = password
    @url = 'http://student-crm.com:3000/member/users'
    mail(to: @user.email, subject: 'New Account on Student Crm')
  end
end
