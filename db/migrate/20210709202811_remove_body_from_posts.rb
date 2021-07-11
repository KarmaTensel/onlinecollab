class RemoveBodyFromPosts < ActiveRecord::Migration[6.1]
  def self.up
    remove_column :posts, :body
  end
  def self.down
    add_column :posts, :body, :text
  end
end
