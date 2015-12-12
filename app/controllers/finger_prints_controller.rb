class FingerPrintsController < ApplicationController
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
    @finger_print = FingerPrint.new(params[:finger_print])

    respond_to do |format|
      if @finger_print.save
        format.html { redirect_to @finger_print, notice: 'Finger print was successfully created.' }
        format.json { render json: @finger_print, status: :created, location: @finger_print }
      else
        format.html { render action: "new" }
        format.json { render json: @finger_print.errors, status: :unprocessable_entity }
      end
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
end
