class AddSchedulcolsPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :published_at, :datetime
    add_column :posts, :publish_at, :datetime
  end
end
