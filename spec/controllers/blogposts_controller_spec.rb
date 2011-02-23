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
    
    it "should have average ratings for each post" do

      @blogposts.each do |blogpost|
        Factory(:rating, :blogpost => blogpost, :score => 1 + rand(5))
        Factory(:rating, :blogpost => blogpost, :score => 1 + rand(5))
        blogpost.save
      end
      
      get :index
      @blogposts.each do |blogpost|
        response.should have_selector("span", :content => blogpost.average_rating)
      end
    end
    
  end

  describe "POST 'create'" do

      describe "failure" do

        before(:each) do
          @attr = { :title => "", :content => ""}
        end

        it "should not create a blogpost" do
          lambda do
            post :create, :blogpost => @attr
          end.should_not change(Blogpost, :count)
        end

        it "should render the 'new' page" do
          post :create, :blogpost => @attr
          response.should render_template('new')
        end
      end
      
      describe "success" do
        
        before(:each) do
          @attr = { :title => "New Post", :content => "Praesent ut purus eu sapien vestibulum accumsan"}
        end
        
        it "should create a blogpost" do
          lambda do
            post :create, :blogpost => @attr
          end.should change(Blogpost, :count).by(1)
        end
        
        it "should render show blogpost page" do
          post :create, :blogpost => @attr
          response.should redirect_to(blogpost_path(assigns(:blogpost)))
        end
        
      end
      
  end

  describe "GET 'edit'" do

      before(:each) do
        @blogpost = Factory(:blogpost)
      end

      it "should be successful" do
        get :edit, :id => @blogpost
        response.should be_success
      end
  end
  
  describe "PUT 'update'" do

      before(:each) do
        @blogpost = Factory(:blogpost)
      end

      describe "failure" do

        before(:each) do
          @attr = { :title => "", :content => "" }
        end

        it "should render the 'edit' page" do
          put :update, :id => @blogpost, :blogpost => @attr
          response.should render_template('edit')
        end
      end

      describe "success" do

        before(:each) do
          @attr = { :title => "New title for Blogpost", :content => "Aliquam et sapien est. Ut ac quam ante. Donec commodo placerat magna" }
        end

        it "should update the blogpost" do
          put :update, :id => @blogpost, :blogpost => @attr
          @blogpost.reload
          @blogpost.title.should  == @attr[:title]
          @blogpost.content.should == @attr[:content]
        end

        it "should redirect to the blogpost show page" do
          put :update, :id => @blogpost, :blogpost => @attr
          response.should redirect_to(blogpost_path(@blogpost))
        end
      end
  end

  describe "POST 'rate'" do
    
    before(:each) do
       @blogpost = Factory(:blogpost)
    end
    
    it "should allow to rate Blogpost" do
      lambda do
        post :rate, :id => @blogpost.id , :score => 2
      end.should change(Rating, :count).by(1)
    end
    
    it "should allow to rate Blogpost using ajax" do
      lambda do
        xhr :post, :rate, :id => @blogpost.id , :score => 2
        response.should be_success
      end.should change(Rating, :count).by(1)
    end
  end

end
