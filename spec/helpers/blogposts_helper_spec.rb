require 'spec_helper'

describe BlogpostsHelper do
  
  describe "format average rating" do
    it "should return correct text for average rating display" do
      format_rating_roundoff = format_average_rating "4.3999"
      format_rating_roundoff.should == "4.4 / 5.0"
    end

    it "should return correct text for nil average rating" do
      format_rating_roundoff = format_average_rating nil
      format_rating_roundoff.should == "Unrated. Be the first to rate!"
    end
  end

  describe "format count of ratings" do
    it "should return blank for 0 count" do
      format_count_for_zero = format_count_of_ratings 0
      format_count_for_zero.should == ""
    end

    it "should return correct text for 1 count" do
      format_count_for_one = format_count_of_ratings 1
      format_count_for_one.should == "(1 rating)"
    end

    it "should return correct text for more than 1 count" do
      format_count_for_more_than_one = format_count_of_ratings 5
      format_count_for_more_than_one.should == "(5 ratings)"
    end


  end
end