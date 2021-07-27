module UsersHelper
  
  def user_role(user)
    if user.user?
      "Role: #{user.role} at #{user.company}"
    else
      "Role: #{user.role}"
    end
  end

  def user_score()
    post_score = 0
    answer_score = 0

    for post in Post.where(user_id: current_user.id)
      p_votes = post.get_upvotes.sum(:vote_weight)-post.get_downvotes.sum(:vote_weight)
      post_score += p_votes

      if post.accepted_answer_user_id == current_user.id
        post_score += 10
      end

    end

    for answer in Answer.where(user_id: current_user.id)
      a_votes = answer.get_upvotes.sum(:vote_weight)-answer.get_downvotes.sum(:vote_weight)
      answer_score += a_votes
    end

    return (post_score+answer_score)
    
  end

end