require 'spec_helper'

describe BlogpostsController do
  render_views
  
  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end
  
  describe "GET 'show'" do

    before(:each) do
           @blogpost = Factory(:blogpost)
    end

    it "should be successful" do
      get :show, :id => @blogpost
      response.should be_success  
    end

    it "should find the right blogpost" do
      get :show, :id => @blogpost
      assigns(:blogpost).should == @blogpost
    end
  
  end
  
  describe "GET 'index'" do
    before(:each) do
      first_post = Factory(:blogpost , :title => "First Entry")
      second_post = Factory(:blogpost , :title => "Second Entry")
      third_post = Factory(:blogpost , :title => "Third Entry")
      @blogposts = [first_post , second_post , third_post]
    end
    
    it "should be successful" do
      get :index
      response.should be_success
    end

    it "should have an element for each post" do
      get :index
      @blogposts.each do |blogpost|
        response.should have_selector("span", :content => blogpost.title)
      end
    end
    
  end

end
