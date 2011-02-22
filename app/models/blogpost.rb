class Blogpost < ActiveRecord::Base
  attr_accessible :title, :content
  validates :title, :presence => true,
                    :uniqueness => true
  validates :content, :presence => true
  
end
