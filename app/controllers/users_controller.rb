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
    auth_update(token, nickname)
  end

  private

  def auth_update(token, nickname)
    current_user.update_attribute(:github_token, token)
    current_user.update_attribute(:github_nickname, nickname)
    flash[:success] = "You're now connected to Github!"
    redirect_to dashboard_path
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
