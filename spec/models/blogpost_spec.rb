require 'spec_helper'

describe Blogpost do
  before(:each) do
    @attr = { :title => "Dummy title", :content => "dummy content" }
  end

  it "should create a new instance given valid attributes" do
    Blogpost.create!(@attr)
  end

  it "should require a title" do
    no_title_blogpost = Blogpost.new(@attr.merge(:title => ""))
    no_title_blogpost.should_not be_valid
  end
  
  it "should require content" do
    no_content_blogpost = Blogpost.new(@attr.merge(:content => ""))
    no_content_blogpost.should_not be_valid
  end
  
  it "should require title to be unique" do
    unique_title_blogpost = Blogpost.create(@attr.merge(:title => "Unique title"))
    non_unique_title_blogpost = Blogpost.new(@attr.merge(:title => "Unique title"))
    non_unique_title_blogpost.should_not be_valid
  end
  
  describe "rating associations" do

      before(:each) do
        @blogpost = Blogpost.create(@attr)
      end

      it "should have a ratings attribute" do
        @blogpost.should respond_to(:ratings)
      end
  end
  
  describe "average rating" do
    before(:each) do
      @blogpost = Blogpost.new(@attr)
      @blogpost.save
    end
    
    it "should return average rating" do
      @blogpost.ratings.build(:score => 5).save
      @blogpost.ratings.build(:score => 3).save
      @blogpost.ratings.build(:score => 1).save
      @blogpost = Blogpost.find_by_id(@blogpost.id)
      @blogpost.average_rating.should == 3
    end
    
    
  end  
  
end
