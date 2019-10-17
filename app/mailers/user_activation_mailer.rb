class UserActivationMailer < ApplicationMailer
  def activate(current_user)
    @user_id = current_user.id

    mail(to: current_user.email, subject: "Brownfield Activation")
  end
end
