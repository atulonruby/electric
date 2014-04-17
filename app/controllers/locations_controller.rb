class LocationsController < ApplicationController

  def index
    @old_locations = Location.happening_before(Time.zone.now).sort_by(&:date)
    @locations = Location.happening_after(Time.zone.now).sort_by(&:date)
    @message = Message.new
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @locations }
    end
  end


  def show
    @location = Location.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @location }
    end
  end


  def new
    @location = Location.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @location }
    end
  end


  def edit
    @location = Location.find(params[:id])
  end


  def create
    @location = Location.new(params[:location])

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render json: @location, status: :created, location: @location }
      else
        format.html { render action: "new" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @location = Location.find(params[:id])

    respond_to do |format|
      if @location.update_attributes(params[:location])
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    respond_to do |format|
      format.html { redirect_to locations_url }
      format.json { head :no_content }
    end
  end
  
  def message
   @message = Message.new(params[:message]) 
   @context = "why me"
   if @message.valid?
     UserMailer.registration_confirmation(@message).deliver
     @context = "success"
   else
     @context = "try again"
   end
 end
     

end
