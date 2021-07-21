class Posts::CommentsController < ApplicationController
	after_action :verify_authorized
	before_action :set_comment, only: %i[ create edit update destroy ]

	def create
		@comment = @post.comments.build(comment_params)
		@comment.user_id = current_user.id
		
		if @comment.save
      		flash[:notice] = "Comment created."
      		redirect_to post_path(@post)
    	else
      		flash.now[:danger] = "Error creating comment."
    	end
	end

	def edit
		authorize @commentable
	end
	
	def update
		authorize @commentable

		if @comment.update(comment_params)
			redirect_to @post, notice: "Your comment has been updated!"
		else	
			render 'edit'
		end
	end

	def destroy
		authorize @commentable

		@comment = @post.comments.find(params[:id])
		if @comment.destroy
			redirect_to post_path(@post), notice: "Your comment has been successfully deleted."
		else
			redirect_to post_path(@post), notice: "Error deleting comment."
		end
	end

	private

		def set_comment
			@post = Post.find(params[:post_id])
			@comment = @post.comments.find(params[:id])
		end
		
	private	
		def comment_params
			params.require(:comment).permit(:post_id, :body)
		end
end
