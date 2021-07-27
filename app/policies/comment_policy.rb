class CommentPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @commentable = model
  end

	def edit?
    @current_user.moderator? || @current_user.admin?
	end
	
	def update?
    @current_user.moderator? || @current_user.admin?
	end

  def destroy?
    @current_user.moderator? || @current_user.admin?
  end

end