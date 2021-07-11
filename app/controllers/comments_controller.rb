class CommentsController < ApplicationController
	
	def index
		@comment = Comment.all.with_rich_text_content
	end

	def new
		user = session[:id]
		@comment = Comment.new(post_id: params[:post_id])
		@post = Post.find(params[:post_id])
	end

	def create
		# @post = Post.find(params[:id])

		# @comment = current_user.comments.new(comment_params)
     	# @postid = params[:id]	
		# @comment.user_id = current_user.id

		@post = Post.find(params[:post_id])
		@comment = @post.comments.create(comment_params)
		redirect_to posts_path(@post)
		
		# if @comment.save
      	# 	flash[:notice] = "comment created."
      	# 	redirect_to '/posts'
    	# else
      	# 	flash[:error] = "Error creating comment."
      	# 	redirect_to '/posts'
    	# end
	end

	def edit
		@comment = Comment.find(params[:id])
	end

	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
		redirect_to
	end

	private
		def comment_params
			params.require(:comment).permit(:post_id, :user_id, :content)
		end
end
