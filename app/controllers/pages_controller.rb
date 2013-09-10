class PagesController < ApplicationController
  def home
    @blop = Blopp.all
    @news = News.all
  end
  
  def about
  end
end
