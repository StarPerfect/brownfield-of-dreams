class UserActivationMailer < ApplicationMailer
  def activate
    @user_id = #XXXX

    mail to: "to@example.org"
  end
end
