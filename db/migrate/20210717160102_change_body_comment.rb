class ChangeBodyComment < ActiveRecord::Migration[6.1]
  def change
    change_column :comments, :body, :binary
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
