class NewsController < ApplicationController
  def index
    @news = News.all.sort_by(&:created_at).reverse
  end
  
  def show
    @news = News.where(:id => params[:id]).first
  end
end
