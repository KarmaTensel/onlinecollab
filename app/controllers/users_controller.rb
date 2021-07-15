class UsersController < ApplicationController
    before_action :authenticate_user!
    after_action :verify_authorized
  
    def index
      @users = User.all
      authorize User
    end
  
    def show
      @user = User.find(params[:id])
      authorize @user
      @post = Post.find(params[:id])
    end
  
    def update
      @user = User.find(params[:id])
      authorize @user
      if @user.update(secure_params)
        redirect_to users_path, :notice => "User updated."
      else
        redirect_to users_path, :alert => "Unable to update user."
      end
    end
  
    def destroy
      user = User.find(params[:id])
      authorize user
      if user.destroy
        redirect_to users_path, :notice => "User deleted."
      end
    end
  
    private

      def secure_params
          params.require(:user).permit(:role)
      end
  
  end