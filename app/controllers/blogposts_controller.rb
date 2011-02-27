class BlogpostsController < ApplicationController
  def new
    @blogpost = Blogpost.new
  end

  def index
    @blogposts = Blogpost.all(:order => "created_at DESC")
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
  
  def rate
    @blogpost = Blogpost.find(params[:id])
    @blogpost.ratings.build(:score => params[:score]).save
    flash[:success] = "Thanks for rating!"
    @blogpost.reload
    respond_to do |format|
      format.html { redirect_to @blogpost } #FIXME - Should redirect to request origin
      format.js
    end  
  end

  def number_of_ratings
    return Blogpost.find(params[:id]).ratings.count
  end
end
