class PagesController < ApplicationController
  def home
    @blop = Blopp.all.sort_by(&:created_at).reverse
    @news = News.all.sort_by(&:created_at).reverse
    @banner = Banner.first
  end
  
  def about
    @banner = Banner.all
  end
end
