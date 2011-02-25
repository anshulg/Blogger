require 'spec_helper'

describe Blogpost do
  before(:each) do
    @attr = { :title => "Dummy title", :content => "dummy content" }
  end

  it "should create a new instance given valid attributes" do
    Blogpost.create!(@attr)
  end
  
  it "should set modification time" do
    @blogpost = Blogpost.create!(@attr)
    @blogpost.modified_at.should_not be_nil
  end

  it "should update modification time on title change" do
    @blogpost = Blogpost.create!(@attr)
    @blogpost.title = "New Title"
    lambda do
      @blogpost.save 
    end.should change(@blogpost,:modified_at)
  end

  it "should update modification time on content change" do
    @blogpost = Blogpost.create!(@attr)
    @blogpost.content = "New Content"
    lambda do
      @blogpost.save 
    end.should change(@blogpost,:modified_at)
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
      @blogpost.average_rating.should == 3.0
    end
    
    it "should not update modified timestamp" do      
      lambda do
        @blogpost.ratings.build(:score => 5).save 
      end.should_not change(@blogpost,:modified_at)
    end
    
  end  
  
  describe "count of ratings" do
    before(:each) do
      @blogpost = Blogpost.new(@attr)
      @blogpost.save
    end
    
    it"should return count of ratings" do
      @blogpost.ratings.build(:score => 5).save
      @blogpost.ratings.build(:score => 3).save
      @blogpost.ratings.build(:score => 1).save
      
      @blogpost.count_of_ratings.should == 3
    end
  end
  
end
