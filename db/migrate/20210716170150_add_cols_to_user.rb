class AddColsToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :username, :string
    add_column :users, :designation, :string
    add_column :users, :company, :string

    User.update_all(username: 'unknown')

    change_column_null :users, :username, false
  end
end
