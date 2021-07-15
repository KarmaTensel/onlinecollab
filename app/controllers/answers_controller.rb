class AnswersController < ApplicationController
    
    def create
		@post = Post.find(params[:post_id])
		@answer = @post.answers.create(answer_params)
		@answer.user_id = current_user.id
		
		if @answer.save
      		flash[:notice] = "Your answer has been posted."
      		redirect_to post_path(@post)
    	else
      		flash.now[:danger] = "Error posting your answer."
    	end
	end

	def edit
		@answer = answer.find(params[:id])
	end

	def destroy
		@answer = answer.find(params[:id])
		@answer.destroy
		flash[:notice] = "Your answer has been deleted."
		redirect_to post_path(@post)
	end

	private
		def answer_params
			params.require(:answer).permit(:post_id, :content)
		end
end
