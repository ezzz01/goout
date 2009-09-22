class UniversitiesController < ApplicationController
  # GET /universities
  # GET /universities.xml
  def index
    @universities = University.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @universities }
    end
  end

  # GET /universities/1
  # GET /universities/1.xml
  def show
    @university = University.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @university }
    end
  end

  # GET /universities/new
  # GET /universities/new.xml
  def new
    @university = University.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @university }
    end
  end

  # GET /universities/1/edit
  def edit
    @university = University.find(params[:id])
  end

  # POST /universities
  # POST /universities.xml
  def create
    @university = University.new(params[:university])

    respond_to do |format|
      if @university.save
        flash[:notice] = 'University was successfully created.'
        format.html { redirect_to(@university) }
        format.xml  { render :xml => @university, :status => :created, :location => @university }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @university.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /universities/1
  # PUT /universities/1.xml
  def update
    @university = University.find(params[:id])

    respond_to do |format|
      if @university.update_attributes(params[:university])
        flash[:notice] = 'University was successfully updated.'
        format.html { redirect_to(@university) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @university.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /universities/1
  # DELETE /universities/1.xml
  def destroy
    @university = University.find(params[:id])
    @university.destroy

    respond_to do |format|
      format.html { redirect_to(universities_url) }
      format.xml  { head :ok }
    end
  end
end
