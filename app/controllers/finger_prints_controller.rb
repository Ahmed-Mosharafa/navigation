class FingerPrintsController < ApplicationController
  #protect_from_forgery
  skip_before_filter :verify_authenticity_token, if: :json_request?, :only => [:new, :create, :localization]
  #protected
  #Checks whether it's a json format or not
  def json_request?
    request.format.json?
  end
  # GET /finger_prints
  # GET /finger_prints.json
  def index
    @finger_prints = FingerPrint.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @finger_prints }
    end
  end

  # GET /finger_prints/1
  # GET /finger_prints/1.json
  def show
    #debugger
    @finger_print = FingerPrint.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @finger_print }
    end
  end
  # GET /finger_prints/new
  # GET /finger_prints/new.json
  def new
    @finger_print = FingerPrint.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @finger_print }
    end
  end

  # GET /finger_prints/1/edit
  def edit
    @finger_print = FingerPrint.find(params[:id])
  end

  # POST /finger_prints
  # POST /finger_prints.json
  def create
    label = false 
    # begin
    #   parameters = ActiveSupport::JSON.decode(request.body.read)[:finger_print]
    # rescue
    parameters = params[:finger_print]
    # end
    available = FingerPrint.new_fingerprint(parameters[:xcoord] , parameters[:ycoord], parameters[:mac])
    #debugger
    # available = 0  means that it's a new fingerprint for a new mac address 
    # this means that I want to save it
    if (available == 0)
      @finger_print = FingerPrint.new(parameters)
      available = FingerPrint.fetch_last_id() + 1  
      #debugger
      respond_to do |format|
        if @finger_print.save
          format.html { redirect_to @finger_print, notice: 'Finger print was successfully created.' }
          format.json { render json: @finger_print, status: :created, location: @finger_print }
        else
          format.html { render action: "new" }
          format.json { render json: @finger_print.errors, status: :unprocessable_entity }
        end
      end
      label = true
    end
    #I need to save the fingerprint to the record in both wats 
    WifiFingerPrintsRecord.new_record(available, parameters[:BSSID], parameters[:SSID], parameters[:RSSI], parameters[:channel], parameters[:mac])
    #debugger
    if (label)
      return 0
    end
    respond_to do |format|
      format.html 
      format.json { render json: parameters}
    end
  end

  # PUT /finger_prints/1
  # PUT /finger_prints/1.json
  def update
    @finger_print = FingerPrint.find(params[:id])

    respond_to do |format|
      if @finger_print.update_attributes(params[:finger_print])
        format.html { redirect_to @finger_print, notice: 'Finger print was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @finger_print.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /finger_prints/1
  # DELETE /finger_prints/1.json
  def destroy
    @finger_print = FingerPrint.find(params[:id])
    @finger_print.destroy

    respond_to do |format|
      format.html { redirect_to finger_prints_url }
      format.json { head :no_content }
    end
  end
  #responsible for handling the loc_page view
  def loc_view
    
  end 

  #Passes an array of fingerprint readings to the model to localize  
  def localization
    #debugger
    searched   = params[:finger_print]
    @coordinates = FingerPrint.KNN(searched)
    puts @coordinates
    respond_to do |format|
      format.html     
      format.json {render @coordinates}
    end
  end
end
