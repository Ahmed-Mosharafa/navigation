class WifiFingerPrintsRecordsController < ApplicationController
  # GET /wifi_finger_prints_records
  # GET /wifi_finger_prints_records.json
  def index
    @wifi_finger_prints_records = WifiFingerPrintsRecord.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @wifi_finger_prints_records }
    end
  end

  # GET /wifi_finger_prints_records/1
  # GET /wifi_finger_prints_records/1.json
  def show
    @wifi_finger_prints_record = WifiFingerPrintsRecord.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @wifi_finger_prints_record }
    end
  end

  # GET /wifi_finger_prints_records/new
  # GET /wifi_finger_prints_records/new.json
  def new
    @wifi_finger_prints_record = WifiFingerPrintsRecord.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @wifi_finger_prints_record }
    end
  end

  # GET /wifi_finger_prints_records/1/edit
  def edit
    @wifi_finger_prints_record = WifiFingerPrintsRecord.find(params[:id])
  end

  # POST /wifi_finger_prints_records
  # POST /wifi_finger_prints_records.json
  def create
    @wifi_finger_prints_record = WifiFingerPrintsRecord.new(params[:wifi_finger_prints_record])

    respond_to do |format|
      if @wifi_finger_prints_record.save
        format.html { redirect_to @wifi_finger_prints_record, notice: 'Wifi finger prints record was successfully created.' }
        format.json { render json: @wifi_finger_prints_record, status: :created, location: @wifi_finger_prints_record }
      else
        format.html { render action: "new" }
        format.json { render json: @wifi_finger_prints_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /wifi_finger_prints_records/1
  # PUT /wifi_finger_prints_records/1.json
  def update
    @wifi_finger_prints_record = WifiFingerPrintsRecord.find(params[:id])

    respond_to do |format|
      if @wifi_finger_prints_record.update_attributes(params[:wifi_finger_prints_record])
        format.html { redirect_to @wifi_finger_prints_record, notice: 'Wifi finger prints record was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @wifi_finger_prints_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wifi_finger_prints_records/1
  # DELETE /wifi_finger_prints_records/1.json
  def destroy
    @wifi_finger_prints_record = WifiFingerPrintsRecord.find(params[:id])
    @wifi_finger_prints_record.destroy

    respond_to do |format|
      format.html { redirect_to wifi_finger_prints_records_url }
      format.json { head :no_content }
    end
  end
end
