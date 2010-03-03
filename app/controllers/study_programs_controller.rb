class StudyProgramsController < ApplicationController
  before_filter :load_subject_area 

  # GET /study_programs
  # GET /study_programs.xml
  def index
    if !@subject_area.blank?
        @study_programs = StudyProgram.find_all_by_subject_area_id(@subject_area) 
    else
        @study_programs = StudyProgram.all    
    end

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
      format.js { render :partial => 'remote_form', :layout => 'modal' }
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
	@study_program.added_by = session[:user_id]
    respond_to do |format|
      if @study_program.save
        flash[:notice] = 'StudyProgram was successfully created.'
        format.html { redirect_to(@study_program) }
        format.xml  { render :xml => @study_program, :status => :created, :location => @study_program }
        format.js {
            subject_area = SubjectArea.find(params[:study_program][:subject_area_id], :include => :study_programs, :order => 'concepts.title', :conditions => [ "concepts.pending = 0 OR concepts.added_by = ?", session[:user_id] ])
            render :update do |page|
                page.replace_html 'study_program', :partial => 'activities/study_programs', :locals => {:id => params[:study_program][:subject_area_id] },  :object => subject_area.study_programs
                page[:activity_study_program_id].set_style :width => "400px"
                page << "lightbox.prototype.deactivate();"
                page << "initialize();" 
                flash.discard
            end
        }
      else
        format.html { render :action => "new" }
        format.js { 
            render :update do |page|
                page << "alert(' #{t(:error_saving_study_program)}');"
                page << "lightbox.prototype.deactivate();"
                flash.discard
            end
        }
#    format.xml  { render :xml => @study_program.errors, :status => :unprocessable_entity }
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
    if params[:subject_area_id]
        @subject_area = SubjectArea.find(params[:subject_area_id])
    else
        @subject_area = nil    
    end

  end



end
