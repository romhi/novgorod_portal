class Messages < ApplicationMailer

  def new_message(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Отдел РК')
  end

end
