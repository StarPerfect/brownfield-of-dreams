class InviteController < ApplicationController
  def index
  end

  def create
    @user = EmailFacade.new(current_user)
    friend_user = @user.email(invitation_params[:sendee])
    if friend_user.login == nil
      flash[:notice] = 'The handle you entered is not a valid GitHub user. Please try again.'
      redirect_to invite_path
    elsif friend_user.email == nil
      flash[:notice] = "The Github user you selected doesn't have an email address associated with their account."
      redirect_to dashboard_path
    else
      InvitationNotificationMailer.invite(current_user, friend_user).deliver_now
      flash[:notice] = "Successfully sent invite!"
      redirect_to dashboard_path
    end
  end

  private

  def invitation_params
    params.permit(:sendee)
  end
end
