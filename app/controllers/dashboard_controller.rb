class DashboardController < ApplicationController
  def show
    @user = User.find(session[:id])
  end
end
