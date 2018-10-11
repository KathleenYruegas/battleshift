module Api
  module V1
    class UsersController < ApiController
      def index
        render json: User.all
      end

      def show
        render json: User.find(params[:id])
      end

      def update
        user = User.find(params[:id])
        user.update_attribute(:email, params[:email])
        render json: User.find(params[:id])
      end
    end
  end
end
