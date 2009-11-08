class StudiesController < ApplicationController
  def index 
    @studies = Study.find(:all)
  end

  def show

  end

  def new 
    @universities = University.find(:all)
    @study = Study.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @study}
    end

  end

  def edit

  end

  def create
    @study = Study.new(params[:study])

    respond_to do |format|
      if @study.save
        flash[:notice] = 'Study was successfully created.'
        format.html { redirect_to(@study) }
        format.xml  { render :xml => @study, :status => :created, :location => @study}
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @study.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update

  end

  def update

  end

  end
