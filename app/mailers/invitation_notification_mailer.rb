class InvitationNotificationMailer < ApplicationMailer
  def invite(current_user, friend)
    @sender = current_user
    @friend = friend
    @url = 'https://infinite-taiga-32566.herokuapp.com/register'
   mail(to: @friend.email, subject: "Invitation to Brownfield of Dreams")
  end
end
