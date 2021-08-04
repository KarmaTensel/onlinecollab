class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy upvote downvote ]
  skip_before_action :authenticate_user!, :only => [:index]
  # before_action :true_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all.order('created_at DESC')
  end

  # GET /posts/1 or /posts/1.json
  def show
    # if @post.status == 'Draft'
    #   @user = current_user
    #   authorize @user
    # elsif @post.status == 'Archive'
    #   @user = current_user.moderator! && current_user
    #   authorize @user
    # end
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.new(post_params)
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save && @subpost.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @post.destroy
        format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end

  # def true_user
  #   skip authorization
  #   @post = current_user.posts.find_by(id: params[:id])
  #   redirect_to posts_path, notice: "Not authorized to edit this Post" if @post.nil? 
  # end

  def upvote
    @post.upvote_from current_user
    redirect_to @post, notice: "You have upvoted this post."
  end

  def downvote
    @post.downvote_from current_user
    redirect_to @post, notice: "You have downvoted on this post."
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :tags, :content, :status, :visibility,
       :publish_at,
       subposts_attributes:{
          :title
       })
    end
    
end
