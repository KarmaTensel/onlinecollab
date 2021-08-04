class PostPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @user = current_user
    @post = model
  end

  def index?
    true
  end

  def show?
    user.present? 
  end

  def new?
    user.present?
  end

  def create?
    user.present?
  end

  def edit?
    return true if @user.present? && user == post.user || user.moderator?
  end

  def update?
    return true if user.present? && user == post.user || user.moderator?
  end

  def destroy?
    return true if user.present? && user == post.user || user.moderator?
  end

end