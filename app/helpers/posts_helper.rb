module PostsHelper
  def accept_answer(approvable) 
    approvable.nil? ? answer.id : 2 
  end
end
