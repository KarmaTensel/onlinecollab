class AddUniqueUsernameUser < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :username, :string, :null => false
    add_column :users, :username, :string
    add_index :users, :username, unique: true
  end
end