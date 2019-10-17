# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    render locals: {
      facade: UserFacade.new(current_user)
    }
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  def callback
    token = request.env['omniauth.auth']['credentials']['token']
    nickname = request.env['omniauth.auth']['info']['nickname']
    uid = request.env['omniauth.auth']['uid']
    auth_update(token, nickname, uid)
    flash[:success] = "You're now connected to Github!"
    redirect_to dashboard_path
  end

  private

  def auth_update(token, nickname, uid)
    current_user.update_attribute(:github_token, token)
    current_user.update_attribute(:github_nickname, nickname)
    current_user.update_attribute(:github_uid, uid)
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
