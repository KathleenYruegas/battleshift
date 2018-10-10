class UserPresenter
  attr_reader :filter

  def initialize(filter = {})
    @filter = filter
  end

  def single_user_object
     UserDisplay.new(user_service.single_user_data)
  end

  def all_users
     user_service.all_user_data.map do |user_data|
      UserDisplay.new(user_data)
    end
  end
  private
  def user_service
    UserService.new(filter)
  end
end
