class UserMailer < ApplicationMailer
  def welcome(user)
    @user = user

    mail to: user.email, subject: 'Just Watches Store. Hello and wellcome!'
  end
end
