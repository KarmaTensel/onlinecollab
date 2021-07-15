class CommentsController < ApplicationController
	before_action :set_post, only: %i[ create destroy ]

	def create
		@comment = @post.comments.create(comment_params)
		@comment.user_id = current_user.id
		
		if @comment.save
      		flash[:notice] = "Comment created."
      		redirect_to post_path(@post)
    	else
      		flash.now[:danger] = "Error creating comment."
    	end
	end

	def edit
	end
	
	def update
		@comment = @post.comments.find(params[:id])
		@comment.update_attributes(comment_params)
		if @comment.update(comment_params)
			redirect_to post_path(@post)
		else
			render '/post'
		end
	end

	def destroy
		
		@comment = Comment.find(params[:id])
		@comment.destroy
		redirect_to post_path(@post)
	end

	private
		def set_post
			@post = Post.find(params[:post_id])
		end

	private
		def comment_params
			params.require(:comment).permit(:post_id, :body)
		end
end
