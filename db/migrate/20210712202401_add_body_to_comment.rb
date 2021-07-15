class AddBodyToComment < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :body, :text
    
    Comment.update_all(user_id: 1, post_id: 3, body: 'First comment')

    change_column_null :comments, :body, false
  end
end
