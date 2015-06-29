class Notifier < ApplicationMailer
  def send_info user
    @user = user
    mail to: user[:email], subject: "Account to sigin Member Manager System"
  end
end
