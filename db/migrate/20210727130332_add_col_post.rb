class AddColPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :accepted_answer_user_id, :integer, unique: true
  end
end
