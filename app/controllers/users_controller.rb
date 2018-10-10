class UsersController < ApplicationController
  def new
    @user = User.new()
  end

  def create
    @user = User.create(user_params)
    if @user.save
      redirect_to '/dashboard'
    else
      render :new
    end 
  end

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
    flash.notice = "Successfully updated #{@user.name}."
    redirect_to '/users'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
