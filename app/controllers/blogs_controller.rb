class BlogsController < ApplicationController
  def index
     @blogs = Blopp.all
  end
  
  def show
     @blog = Blopp.where(:id => params[:id]).first
  end
  
  def new
    @blog = Blopp.new
  end
  
  def edit
    @blog = Blopp.find(params[:id])
  end
  
  def create
     @blog = Blopp.new(params[:blog])

     respond_to do |format|
       if @blog.save
         format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
         format.json { render json: @blog, status: :created, location: @location }
       else
         format.html { render action: "new" }
         format.json { render json: @blog.errors, status: :unprocessable_entity }
       end
     end
   end
   
  def update
    @blog = Blopp.find(params[:blog])

    respond_to do |format|
      if @blog.update_attributes(params[:blog])
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end
   
  def destroy
    @blog = Blopp.find(params[:id])
    @blog.destroy
  end
end
