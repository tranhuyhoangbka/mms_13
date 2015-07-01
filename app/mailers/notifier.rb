class Notifier < ApplicationMailer
  def create_user user
    @user = user
    mail to: @user[:email], subject: t("mail.subject")
  end
end
