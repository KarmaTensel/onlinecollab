module UsersHelper
  
  def user_role(user)
    if user.user?
      "Role: #{user.role} at #{user.company}"
    else
      "Role: #{user.role}"
    end
  end
  
end