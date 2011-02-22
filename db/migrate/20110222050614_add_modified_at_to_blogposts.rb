class AddModifiedAtToBlogposts < ActiveRecord::Migration
  def self.up
    add_column :blogposts, :modified_at, :timestamp
  end

  def self.down
    remove_column :blogposts, :modified_at
  end
end
