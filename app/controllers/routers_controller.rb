class RoutersController < ApplicationController
  # GET /routers
  # GET /routers.json
  def index
    @routers = Router.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @routers }
    end
  end

  # GET /routers/1
  # GET /routers/1.json
  def show
    @router = Router.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @router }
    end
  end

  # GET /routers/new
  # GET /routers/new.json
  def new
    @router = Router.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @router }
    end
  end

  # GET /routers/1/edit
  def edit
    @router = Router.find(params[:id])
  end

  # POST /routers
  # POST /routers.json
  def create
    @router = Router.new(params[:router])

    respond_to do |format|
      if @router.save
        format.html { redirect_to @router, notice: 'Router was successfully created.' }
        format.json { render json: @router, status: :created, location: @router }
      else
        format.html { render action: "new" }
        format.json { render json: @router.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /routers/1
  # PUT /routers/1.json
  def update
    @router = Router.find(params[:id])

    respond_to do |format|
      if @router.update_attributes(params[:router])
        format.html { redirect_to @router, notice: 'Router was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @router.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /routers/1
  # DELETE /routers/1.json
  def destroy
    @router = Router.find(params[:id])
    @router.destroy

    respond_to do |format|
      format.html { redirect_to routers_url }
      format.json { head :no_content }
    end
  end
end
