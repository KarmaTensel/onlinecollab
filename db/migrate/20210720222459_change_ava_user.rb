class ChangeAvaUser < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :avatar, :string
  end
end
