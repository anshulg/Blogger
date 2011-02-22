class BlogpostsController < ApplicationController
  def new
    @blogpost = Blogpost.new
  end

  def index
    @blogposts = Blogpost.all
  end
  
  def show
    @blogpost = Blogpost.find(params[:id])
  end
end
