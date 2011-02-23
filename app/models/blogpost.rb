class Blogpost < ActiveRecord::Base
  attr_accessible :title, :content
  validates :title, :presence => true,
                    :uniqueness => true
  validates :content, :presence => true
  
  has_many :ratings
  
  before_save :set_modified_timestamp
  
  def average_rating
    number_with_precision(read_attribute(:average_rating), :precision => 1)
  end
  
  private 
  
  def set_modified_timestamp
     self.modified_at = Time.now if self.title_changed? or self.content_changed?
  end

end
