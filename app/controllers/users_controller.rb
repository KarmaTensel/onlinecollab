class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user, only: %i[ show update destroy ]
  
    def new
      @users = User.new
    end

    def index
      @users = User.all
    end
  
    def show
      @post = Post.all.reverse
      @answer = Answer.all.reverse
    end

    def edit
      user = User.find_by(id: params[:id])
      if current_user == user
        user.update()
      end
    end
  
    def update
      if @user.update(secure_params)
        redirect_to users_path, :notice => "User updated."
      else
        render 'edit'
      end
    end
  
    def destroy

      if @user.destroy
        redirect_to users_path, :notice => "User deleted."
      end
    end
  
    private

      def secure_params
          params.require(:user).permit(:role, :designation, :company, :bio, :username, :avatar)
      end

      def set_user
        @user = User.find(params[:id])
      end
  
  end