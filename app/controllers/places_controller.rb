class PlacesController < ApplicationController
  # def check_slashes(path)
  #     if !(/\/\//.match(path))
  #       path.gsub(/\//, "//")
  # GET /places
  # GET /places.json
  def index
    #for getting nearby places
    if (params[:lat]) 
      @places = Place.find_nearby(params[:range], params[:lat], params[:long]).all
    else
      @places = Place.all
      #debugger
    end
   #debugger
   respond_to do |format|
     format.html 
     format.json { render json: @places }
   end
  end
  #renders view nearby 
  def nearby
    
  end
  #renders view search_metadata
  def search_metadata

  end
  #calls fetch_metadata on beacons and routers to respond with the routers and beacons information of the place to be rendered afterwards in metadata.html.erb
  def metadata
    @beacons = Beacon.fetch_metadata(params[:PlaceID])
    @routers = Router.fetch_metadata(params[:PlaceID])
    respond_to do |format|
      format.html # nearby.html.erb
      format.json { render :json => {:beacon => @beacons, :router => @routers } }
    end
  end
  # GET /places/1
  # GET /places/1.json
  def show
    @place = Place.find(params[:id])
    #debugger
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @place }
    end
  end
  #responsible for handling the webview of the map
  def map_view
    @map_link = Place.get_map_link(params[:id])
  end 
  # GET /places/new
  # GET /places/new.json
  def new
    # if (params[:map_link])
    #   check_slashes(params[:map_link])
    @place = Place.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @place }
    end
  end
  
  # GET /places/1/edit
  def edit
    @place = Place.find(params[:id])
  end
  # Creating a new place with post parameters provided at new.html.erb
  # POST /places
  # POST /places.json
  def create
    @place = Place.new(params[:place])

    respond_to do |format|
      if @place.save
        format.html { redirect_to @place, notice: 'Place was successfully created.' }
        format.json { render json: @place, status: :created, location: @place }
      else
        format.html { render action: "new" }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end
  # 
  # PUT /places/1
  # PUT /places/1.json
  def update
    @place = Place.find(params[:id])

    respond_to do |format|
      if @place.update_attributes(params[:place])
        format.html { redirect_to @place, notice: 'Place was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /places/1
  # DELETE /places/1.json
  def destroy
    @place = Place.find(params[:id])
    @place.destroy

    respond_to do |format|
      format.html { redirect_to places_url }
      format.json { head :no_content }
    end
  end
end
