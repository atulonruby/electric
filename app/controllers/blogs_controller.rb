class BlogsController < ApplicationController
  def index
     @blogs = Blopp.all
  end
  
  def show
     @blog = Blopp.where(:id => params[:id]).first
  end
end
