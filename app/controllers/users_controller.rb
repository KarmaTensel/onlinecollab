class UsersController < ApplicationController
    before_action :authenticate_user!
    after_action :verify_authorized
    before_action :set_user, only: %i[ show edit update destroy ]
  
    def index
      @users = User.all
      authorize User
    end
  
    def show
      authorize @user
      @post = Post.find(params[:id])
    end

    def edit

    end
  
    def update
      authorize @user
      if @user.update(secure_params)
        redirect_to users_path, :notice => "User updated."
      else
        redirect_to users_path, :alert => "Unable to update user."
      end
    end
  
    def destroy
      authorize @user
      if @user.destroy
        redirect_to users_path, :notice => "User deleted."
      end
    end
  
    private

      def secure_params
          params.require(:user).permit(:role)
      end

      def set_user
        @user = User.find(params[:id])
      end
  
  end