class DeleteBodyComment < ActiveRecord::Migration[6.1]
  def self.up
    remove_column :comments, :body, :binary, :null => false
  end

  def self.down
    add_column :comments, :body, :binary, :null => false
  end
end
