class CreateSubposts < ActiveRecord::Migration[6.1]
  def change
    create_table :subposts do |t|
      t.string :title

      t.timestamps
    end
  end
end
