class ConfirmationController < ApplicationController
  def show
    @user = User.find_by_activation_token(params[:activation_token])
    @user.account_activation
  end
end
