class PagesController < ApplicationController
  def home
    @blop = Blopp.all
    @news = News.all
    @banner = Banner.all
  end
  
  def about
    @banner = Banner.all
  end
end
