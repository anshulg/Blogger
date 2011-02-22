class AddAverageRatingToBlogposts < ActiveRecord::Migration
  def self.up
    add_column :blogposts, :average_rating, :decimal
  end

  def self.down
    remove_column :blogposts, :average_rating
  end
end
