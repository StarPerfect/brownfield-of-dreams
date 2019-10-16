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
      flash[:success] = "Logged in as #{user.first_name} #{user.last_name}"
      flash[:activation] = 'This account has not yet been activated. Please check your email.'
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  def callback
    token = request.env['omniauth.auth']['credentials']['token']
    nickname = request.env['omniauth.auth']['info']['nickname']
    auth_update(token, nickname)
    flash[:success] = "You're now connected to Github!"
    redirect_to dashboard_path
  end

  private

  def auth_update(token, nickname)
    current_user.update_attribute(:github_token, token)
    current_user.update_attribute(:github_nickname, nickname)
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
