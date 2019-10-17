class ActivationController < ApplicationController
  def activate
    user = User.find(user_params[:id])
    user.update(status: 'active')
    flash[:activate] = "Status: Active"
  end

  private

  def user_params
    params.permit(:id)
  end
end
