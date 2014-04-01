class PagesController < ApplicationController
  def home
    @blop = Blopp.all
    @news = News.all
    @banner = Banner.first
  end
  
  def about
    @banner = Banner.all
  end
end
