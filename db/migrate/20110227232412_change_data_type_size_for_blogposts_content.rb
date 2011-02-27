class ChangeDataTypeSizeForBlogpostsContent < ActiveRecord::Migration
  def self.up
    change_column :blogposts, :content, :text, :limit => nil
  end

  def self.down
    change_column :blogposts, :content, :text, :limit => 255
  end
end
