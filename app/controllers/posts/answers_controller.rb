class Posts::AnswersController < ApplicationController
	before_action :set_answer, only: %i[ edit update accept destroy upvote downvote]

	def create
		@post = Post.find(params[:post_id])
		@answer = @post.answers.build(answer_params)
		@answer.user_id = current_user.id
		
		if @answer.save
				flash[:notice] = "Your answer has been posted."
				redirect_to post_path(@post)
		else
				flash.now[:danger] = "Error posting answer."
		end

	end

	def edit
	end
	
	def update

		if @answer.update(answer_params)
			redirect_to @post, notice: "Your answer has been updated!"
		else	
			render 'edit'
		end
	end

	def destroy
		@answer = @post.answers.find(params[:id])

		if @answer.destroy
			redirect_to post_path(@post), notice: "You answer has been successfully deleted."
		else
			redirect_to post_path(@post), notice: "Error deleting answer."
		end
	end

	def accept
		if @post.update(accepted_answer_id: @answer.id, accepted_answer_user_id: @answer.user_id)
			redirect_to @post, notice: "You have accepted an answer with an ID #{@answer.id} for this post."
		else
			redirect_to @post, notice: "Error accepting an answer."
		end
	end

	def upvote
		@answer.upvote_from current_user
		redirect_to @post, notice: "Upvoted an answer."
	end

	def downvote
		@answer.downvote_from current_user
		redirect_to @post, notice: "Downvoted an answer."
	end

	private

		def set_answer
			@post = Post.find(params[:post_id])
			@answer = @post.answers.find(params[:id])
		end
		
	private	
		def answer_params
			params.require(:answer).permit(:post_id, :content)
		end

end




