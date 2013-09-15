class PicturesController < ApplicationController
  def index
    @pictures = Picture.order('created_at DESC')
  end
  
  def show
    @picture = Picture.find(params[:id])
  end
end
