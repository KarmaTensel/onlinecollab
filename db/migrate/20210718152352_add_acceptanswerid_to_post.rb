class AddAcceptansweridToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :accepted_answer_id, :integer, unique: true
  end
end
