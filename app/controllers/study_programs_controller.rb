class StudyProgramsController < ApplicationController
  before_filter :load_subject_area 

  # GET /study_programs
  # GET /study_programs.xml
  def index
    @study_programs = StudyProgram.find_all_by_subject_area_id(@subject_area) 

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @study_programs }
    end
  end

  # GET /study_programs/1
  # GET /study_programs/1.xml
  def show
    @study_program = StudyProgram.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @study_program }
    end
  end

  # GET /study_programs/new
  # GET /study_programs/new.xml
  def new
    @study_program = StudyProgram.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @study_program }
    end
  end

  # GET /study_programs/1/edit
  def edit
    @study_program = StudyProgram.find(params[:id])
  end

  # POST /study_programs
  # POST /study_programs.xml
  def create
    @study_program = StudyProgram.new(params[:study_program])

    respond_to do |format|
      if @study_program.save
        flash[:notice] = 'StudyProgram was successfully created.'
        format.html { redirect_to(@study_program) }
        format.xml  { render :xml => @study_program, :status => :created, :location => @study_program }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @study_program.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /study_programs/1
  # PUT /study_programs/1.xml
  def update
    @study_program = StudyProgram.find(params[:id])

    respond_to do |format|
      if @study_program.update_attributes(params[:study_program])
        flash[:notice] = 'StudyProgram was successfully updated.'
        format.html { redirect_to(@study_program) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @study_program.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /study_programs/1
  # DELETE /study_programs/1.xml
  def destroy
    @study_program = StudyProgram.find(params[:id])
    @study_program.destroy

    respond_to do |format|
      format.html { redirect_to(study_programs_url) }
      format.xml  { head :ok }
    end
  end

  private

  def load_subject_area
    @subject_area = SubjectArea.find(params[:subject_area_id])
  end



end
