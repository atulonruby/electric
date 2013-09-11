class NewsController < ApplicationController
  def index
    @news = News.all
  end
  
  def show
    @news = News.where(:id => params[:id]).first
  end
end
