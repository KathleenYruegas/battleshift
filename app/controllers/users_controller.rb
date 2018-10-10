class UsersController < ApplicationController

  def index
    @search_result = UserPresenter.new
  end

  def show
    @search_result = UserPresenter.new({id: params[:id]})
  end

  def edit
  end

  def update
    @user = UserPresenter.new({id: params[:id]}).single_user_object
    x = UserService.new({id: params[:id]}).update_user_data(params[:email])
    # require "pry"; binding.pry
    flash.notice = "Successfully updated #{@user.name}."
    redirect_to '/users'
  end
end
