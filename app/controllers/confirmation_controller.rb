class ConfirmationController < ApplicationController
  def edit
    @user = User.find_by_activation_token(params[:id])
    @user.activate_account
    session[:id] = @user.id
  end
end
