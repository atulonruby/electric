class BlogsController < ApplicationController
  def index
     @blogs = Blopp.all
   end
end
