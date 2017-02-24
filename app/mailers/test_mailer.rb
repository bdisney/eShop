class TestMailer < ApplicationMailer
  def welcome_email(user)
    mail(
      :subject => 'hello',
      :to  => 'receiver@just-watches-ror.tk',
      :from => 'sender@just-watches-ror.tk',
      :html_body => '<strong>Hello from Postmark!<strong>',
      :track_opens => 'true'
    )
  end
end
