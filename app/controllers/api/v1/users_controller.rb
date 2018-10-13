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
        user.update(email: user_params[:email])
      end

      def create
        User.new(user_params)
      end

      private
      def user_params
        params.permit(:name, :email, :password)
      end
    end
  end
end
