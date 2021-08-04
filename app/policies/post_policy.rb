class PostPolicy
  attr_reader :current_user, :post

  def initialize(current_user, post)
    @user = current_user
    @post = post
  end

  def index?
   true
  end

  def show?
    post.user?
  end

  def new?
    user.present?
  end

  def edit?
    return true if user == post.user || user.moderator?
  end

  def update?
    return true if user == post.user || user.moderator?
  end

  def destroy?
    return true if user == post.user || user.moderator?
  end

  def upvote
    return false if user == post.user
  end

  def downvote
    return false if user == post.user
  end

end