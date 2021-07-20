class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy]
  skip_before_action :authenticate_user!, :only => [:index]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all.order('created_at DESC')

    # @admin_posts = Post.post_admin.order('created_at DESC')
    # @coworker_posts = Post.post_cowoker.order('created_at DESC')
    # @employee_posts = Post.post_employee.order('created_at DESC')
    # @all_posts = Post.post_all.order('created_at DESC')
  end

  # GET /posts/1 or /posts/1.json
  def show
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
      if @post.save
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

    # if @post.update(ans_params)
    #   flash[:notice] = "Answer accepted!"
    #   redirect_to posts_path(post)
    # else
    #   flash[:notice] = "Error accepting answer. Please try agian."
    #   render "/post"
    # end

  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to posts_path, notice: "Not authorized to edit this Post" if @post.nil? 
  end

  private

    def set_post
      @post = Post.find(params[:id])
      @user = @post.user.email
    end

    def post_params
      params.require(:post).permit(:title, :tags, :content, :status, :visibility, :publish_at)
    end

    # def ans_params
    #   params.require(:post).permit(:accepted_answer_id)
    # end
    
end
