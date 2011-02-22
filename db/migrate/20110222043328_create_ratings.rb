class CreateRatings < ActiveRecord::Migration
  def self.up
    create_table :ratings do |t|
      t.integer :score
      t.integer :blogpost_id

      t.timestamps
    end
    add_index :ratings, :blogpost_id
  end

  def self.down
    drop_table :ratings
  end
end
