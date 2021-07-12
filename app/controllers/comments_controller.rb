class CommentsController < ApplicationController
	
	# def index
	# 	@comment = Comment.all.with_rich_text_content
	# end

	# def new
	# 	@comment = current_user.comment.build
	# end

	def create

		@post = Post.find(params[:post_id])
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
		@comment = Comment.find(params[:id])
	end

	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
		redirect_to '/posts'
	end

	private
		def comment_params
			params.require(:comment).permit(:post_id, :body)
		end
end
