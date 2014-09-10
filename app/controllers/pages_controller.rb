class PagesController < ApplicationController
  def home
    @blop = Blopp.all.sort_by &:created_at
    @news = News.all.sort_by &:created_at
    @banner = Banner.first
  end
  
  def about
    @banner = Banner.all
  end
end
