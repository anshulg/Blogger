class ChangeDataTypeForBlogpostContent < ActiveRecord::Migration
  def self.up
    change_table :blogposts do |t|
      t.change :content, :text 
    end
  end

  def self.down
    change_table :blogposts do |t|
      t.change :content, :string 
    end
  end
end
