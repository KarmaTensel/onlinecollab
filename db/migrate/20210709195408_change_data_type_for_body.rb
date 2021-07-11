class ChangeDataTypeForBody < ActiveRecord::Migration[6.1]
   def self.up
    change_table :posts do |t|
      t.change :body, :rich_text
    end
  end
  def self.down
    change_table :posts do |t|
      t.change :body, :text
    end
  end
end
