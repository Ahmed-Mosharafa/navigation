class MagneticsController < ApplicationController
  # GET /magnetics
    skip_before_filter :verify_authenticity_token, if: :json_request?, :only => [:new, :create, :localization]
  # GET /magnetics.json
  def index
    @magnetics = Magnetic.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @magnetics }
    end
  end

  # GET /magnetics/1
  # GET /magnetics/1.json
  def show
    @magnetic = Magnetic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @magnetic }
    end
  end

  # GET /magnetics/new
  # GET /magnetics/new.json
  def new
    @magnetic = Magnetic.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @magnetic }
    end
  end

  # GET /magnetics/1/edit
  def edit
    @magnetic = Magnetic.find(params[:id])
  end

  # POST /magnetics
  # POST /magnetics.json
  def create
    @magnetic = Magnetic.check_exist(params[:magnetic])

    respond_to do |format|
        format.html { redirect_to @magnetic.find(params[id]), notice: 'Magnetic was successfully created.' }
        format.json { render json: @magnetic.find(params[id]), status: :created, location: @magnetic }
    end
  end

  # PUT /magnetics/1
  # PUT /magnetics/1.json
  def update
    @magnetic = Magnetic.find(params[:id])

    respond_to do |format|
      if @magnetic.update_attributes(params[:magnetic])
        format.html { redirect_to @magnetic, notice: 'Magnetic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @magnetic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /magnetics/1
  # DELETE /magnetics/1.json
  def destroy
    @magnetic = Magnetic.find(params[:id])
    @magnetic.destroy

    respond_to do |format|
      format.html { redirect_to magnetics_url }
      format.json { head :no_content }
    end
  end
  #responsible for handling the loc_page view
  def loc_view
    
  end 

  def localization
    #debugger
    searched   = params[:magnetic]
    @coordinates = Magnetic.KNN(searched)
    puts @coordinates
    respond_to do |format|
      format.html     
      format.json {render json: @coordinates}
    end
  end
end
