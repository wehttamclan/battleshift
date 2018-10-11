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
        user.update(email_params)
      end

      private
      def email_params
        params.permit(:email)
      end
    end
  end
end
