class Rating < ActiveRecord::Base
  attr_accessible :score
  belongs_to :blogpost
  
  validates :blogpost_id, :presence => true
  
  validates_inclusion_of :score, :in => 1..5, :message => "can only be between 1 and 5"
  validates_numericality_of :score, :only_integer => true, :message => "can only be whole number."

  after_destroy :calculate_average_rating
  after_create :calculate_average_rating
  after_update :calculate_average_rating
  
  private
  
  def calculate_average_rating
    average_rating = Rating.average(:score, :conditions => [ 'blogpost_id = ?', blogpost_id ] )
    blogpost = Blogpost.find(:first, blogpost_id)
    blogpost.average_rating = average_rating
    blogpost.save
  end
end
