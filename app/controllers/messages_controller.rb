class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.json
  def index

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
    end
  end

 
  def new
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
  end

 
  def create
    @message = Message.new(params[:message])

    respond_to do |format|
      if @message.valid?
        UserMailer.registration_confirmation(@message).deliver
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render json: @message, status: :created, location: @message }
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  
end
