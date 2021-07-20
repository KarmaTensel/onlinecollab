class Posts::AnswersController < ApplicationController
	before_action :set_answer, only: %i[ edit ]
	before_action :set_post, only: %i[ create show edit accept update]
    
	def new
		@answer = Answer.new
	end
	
	def create
		@answer = Answer.new(answer_params)
		@answer.user_id = current_user.id
		@answer.post_id = params[:post_id]
		
		if @answer.save
      		flash[:notice] = "Your answer has been posted."
      		redirect_to post_path(@post)
    	else
      		flash.now[:danger] = "Error posting your answer."
    	end
	end

	def edit
	end

	def accept
		@post = Post.find(params[:id])
    @post.accepted_answer_id = @answer.id
		Post.update(accepted_answer_id: @post.accepted_answer_id)
		redirect_to posts_path, notice: "Answer accepted."
  end

	def destroy
		@answer = Answer.find(params[:post_id])
		if @answer.destroy
			flash[:notice] = "Your answer has been deleted."
			redirect_to post_path
		else
			redirect_to post_path(@post), notice: "Error deleting comment."
		end
	end

	private

		def set_answer
			@answer = Answer.find(params[:id])
		end

		def set_post
			@post = Post.find(params[:post_id])
		end

		def answer_params
			params.require(:answer).permit(:content)
		end

end
