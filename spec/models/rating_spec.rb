require 'spec_helper'

describe Rating do
  before(:each) do
    @blogpost = Factory(:blogpost)
    @attr = { :score => 5 }
  end

  it "should add a new rating" do
    @blogpost.ratings.create!(@attr)
  end

  describe "blogpost associations" do

    before(:each) do
      @rating = @blogpost.ratings.create(@attr)
    end

    it "should have a blogpost attribute" do
      @rating.should respond_to(:blogpost)
    end

    it "should have the right associated blogpost" do
      @rating.blogpost_id.should == @blogpost.id
      @rating.blogpost.should == @blogpost
    end
  end
  
  describe "validations" do

      it "should require a blogpost id" do
        Rating.new(@attr).should_not be_valid
      end

      it "should require value" do
        @blogpost.ratings.build(:score => nil).should_not be_valid
      end

      it "should allow values only from 1 to 5" do
        @blogpost.ratings.build(:score => 6).should_not be_valid
        @blogpost.ratings.build(:score => -1).should_not be_valid
        @blogpost.ratings.build(:score => 5).should be_valid
      end
    
  end
end
