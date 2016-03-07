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
      format.csv { send_data FingerPrint.scoped.to_csv, filename: "fingerprints-#{Date.today}.csv"}
    end
  end

  # GET /finger_prints/1
  # GET /finger_prints/1.jsonl
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
    @finger_print = FingerPrint.check_exist(params[:finger_print])

    respond_to do |format|
        format.html { redirect_to @finger_print.find(params[id]), notice: 'FingerPrint was successfully created.' }
        format.json { render json: @finger_print.find(params[id]), status: :created, location: @finger_print }
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
      format.json {render json: @coordinates}
    end
  end
end
