class ActivitiesController < ApplicationController
  include ApplicationHelper
#  before_filter :protect, :only => ["new", "create", "delete", "update"]

  def new 
    @universities = University.find(:all)
    @activity = Activity.new
    respond_to do |format|
      format.js 
    end
  end

  def edit

  end

  def create
    @activity = Activity.new(params[:study])
    @user = User.find(session[:user_id]) 
    @activity.user_id = @user.id
    respond_to do |format|
      if @activity.save
        format.js 
      end
    end
  end

  def update_universities
    country = Country.find_by_id(params[:country_id], :include => :universities, :order => 'universities.title', :conditions => [ "universities.pending = 0 OR universities.added_by = ?", session[:user_id] ])
	render :update do |page|
        if country.blank?
            page.replace_html 'universities', :partial => 'universities', :locals => {:id => params[:country_id] }, :object => nil
        else 
            page.replace_html 'universities', :partial => 'universities', :locals => {:id => params[:country_id] }, :object => country.universities
        end
        page << "initialize();" 
	end
  end


  def update_study_programs
	subject_area = SubjectArea.find_by_id(params[:subject_area_id], :include => :study_programs, :order => 'study_programs.title', :conditions => [ "study_programs.pending = 0 OR study_programs.added_by = ?", session[:user_id] ])
	render :update do |page|
        if subject_area.blank?
            page.replace_html 'study_programs', :partial => 'study_programs', :locals => {:id => params[:subject_area_id] }, :object => nil
        else
            page.replace_html 'study_programs', :partial => 'study_programs', :locals => {:id => params[:subject_area_id] }, :object => subject_area.study_programs
        end
        page << "initialize();" 
	end
  end

  end
