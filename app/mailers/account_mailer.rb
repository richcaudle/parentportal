class AccountMailer < ActionMailer::Base
  default from: "noreply@satchl.co.uk"

  def forgotpassword(user, token)
    @user = user
    @url  = 'http://localhost:3000'
    @token = token
    mail(to: @user.email, subject: "#{APP_NAME}: Forgotten password")
  end
end
