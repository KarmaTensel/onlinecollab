class AddAvatarUser < ActiveRecord::Migration[6.1]
  def self.up
    add_column :users, :avatar, :binary
  end

  def self.down
    remove_column :users, :avatar, :binary
  end
end
