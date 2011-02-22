class Rating < ActiveRecord::Base
  attr_accessible :score
  belongs_to :blogpost
  
  validates :blogpost_id, :presence => true
  
  validates_inclusion_of :score, :in => 1..5, :message => "can only be between 1 and 5"
  validates_numericality_of :score, :only_integer => true, :message => "can only be whole number."

end
