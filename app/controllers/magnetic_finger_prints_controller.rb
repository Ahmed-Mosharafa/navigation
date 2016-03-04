class MagneticFingerPrintsController < ApplicationController
  # GET /magnetic_finger_prints
  # GET /magnetic_finger_prints.json
  def index
    @magnetic_finger_prints = MagneticFingerPrint.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @magnetic_finger_prints }
    end
  end

  # GET /magnetic_finger_prints/1
  # GET /magnetic_finger_prints/1.json
  def show
    @magnetic_finger_print = MagneticFingerPrint.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @magnetic_finger_print }
    end
  end

  # GET /magnetic_finger_prints/new
  # GET /magnetic_finger_prints/new.json
  def new
    @magnetic_finger_print = MagneticFingerPrint.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @magnetic_finger_print }
    end
  end

  # GET /magnetic_finger_prints/1/edit
  def edit
    @magnetic_finger_print = MagneticFingerPrint.find(params[:id])
  end

  # POST /magnetic_finger_prints
  # POST /magnetic_finger_prints.json
  def create
    @magnetic_finger_print = MagneticFingerPrint.new(params[:magnetic_finger_print])

    respond_to do |format|
      if @magnetic_finger_print.save
        format.html { redirect_to @magnetic_finger_print, notice: 'Magnetic finger print was successfully created.' }
        format.json { render json: @magnetic_finger_print, status: :created, location: @magnetic_finger_print }
      else
        format.html { render action: "new" }
        format.json { render json: @magnetic_finger_print.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /magnetic_finger_prints/1
  # PUT /magnetic_finger_prints/1.json
  def update
    @magnetic_finger_print = MagneticFingerPrint.find(params[:id])

    respond_to do |format|
      if @magnetic_finger_print.update_attributes(params[:magnetic_finger_print])
        format.html { redirect_to @magnetic_finger_print, notice: 'Magnetic finger print was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @magnetic_finger_print.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /magnetic_finger_prints/1
  # DELETE /magnetic_finger_prints/1.json
  def destroy
    @magnetic_finger_print = MagneticFingerPrint.find(params[:id])
    @magnetic_finger_print.destroy

    respond_to do |format|
      format.html { redirect_to magnetic_finger_prints_url }
      format.json { head :no_content }
    end
  end
end
