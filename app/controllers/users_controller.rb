class UsersController < ApplicationController
  def new
    @user = User.new()
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.generate_token
      RegistrationMailer.confirmation(@user).deliver_now
      redirect_to dashboard_path(id: @user.id)
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
    @search_result = UserPresenter.new({id: params[:id]})
  end

  def update
    @user = UserPresenter.new({id: params[:id]}).single_user_object
    UserService.new({id: params[:id]}).update_user_data(params[:email])
    flash.notice = "Successfully updated #{@user.name}."
    redirect_to '/users'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
