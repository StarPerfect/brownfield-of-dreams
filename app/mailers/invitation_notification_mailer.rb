class InvitationNotificationMailer < ApplicationMailer
  def invite(current_user, friend)
    @sender = current_user
    @friend = friend
    @url = '/signup'
   mail(to: @friend, subject: "Invitation to Brownfield of Dreams")
  end
end
