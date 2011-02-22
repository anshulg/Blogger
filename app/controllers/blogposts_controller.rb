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
  
  def create
    @blogpost = Blogpost.new(params[:blogpost])
    if @blogpost.save
      redirect_to @blogpost
    else
      render 'new'
    end
  end
  
  def edit
    @blogpost = Blogpost.find(params[:id])
  end
  
  def update
    @blogpost = Blogpost.find(params[:id])
    if @blogpost.update_attributes(params[:blogpost])
      redirect_to @blogpost
    else
      render 'edit'
    end
  end
  
end
