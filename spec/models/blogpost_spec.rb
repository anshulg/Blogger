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
end
