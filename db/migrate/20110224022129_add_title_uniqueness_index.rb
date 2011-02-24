class AddTitleUniquenessIndex < ActiveRecord::Migration
  def self.up
    add_index :blogposts, :title, :unique => true
  end

  def self.down
    remove_index :blogposts, :title
  end
end
