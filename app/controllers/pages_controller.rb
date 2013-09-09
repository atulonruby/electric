class PagesController < ApplicationController
  def home
    @blog = Blop.all
  end
  
  def about
  end
end
