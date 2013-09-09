class PagesController < ApplicationController
  def home
    @blog = Blop.all
    @blop = Blopp.all
  end
  
  def about
  end
end
