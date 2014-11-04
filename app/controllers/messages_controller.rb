class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.json
  caches_page :new
  def index

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
    end
  end

 
  def new
    @message = Message.new

    respond_to do |format|
      format.html 
      format.json { render json: @message }
    end
  end

 
  def create
    @message = Message.new(params[:message])

    respond_to do |format|
      if @message.valid?
        UserMailer.registration_confirmation(@message).deliver
        format.html { redirect_to @message, notice: 'Message was successfully sent.' }
        format.json { render json: @message, status: :created, location: @message }
      else
        format.html { render action: "new",notice: 'Please try again'  }
      end
    end
  end

  
end
