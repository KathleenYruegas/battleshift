class ConfirmationController < ApplicationController
  def show
    @user = User.find_by_activation_token(params[:user_id])
    @user.account_activation
  end
end
