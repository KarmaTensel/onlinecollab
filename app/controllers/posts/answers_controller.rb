class Posts::AnswersController < ApplicationController
	before_action :set_answer, only: %i[ create edit update destroy ]

	def create
		@answer = @post.answers.build(answer_params)
		@answer.user_id = current_user.id
		
		if @answer.save
				flash[:notice] = "Your answer has been created."
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




