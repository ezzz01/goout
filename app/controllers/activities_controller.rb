class ActivitiesController < ApplicationController
  include ApplicationHelper
#  before_filter :protect, :only => ["new", "create", "delete", "update"]

  def new 
    @organizations = Organization.find(:all)
    @activity = Activity.new
    respond_to do |format|
      format.js 
    end
  end

  def edit

  end

  def create
    if(params[:my_type] == "full_study")
        @activity = FullStudy.new(params[:activity])
    elsif(params[:my_type] == "exchange_study")
        @activity = ExchangeStudy.new(params[:activity])
    elsif(params[:my_type] == "internship")
        @activity = Internship.new(params[:activity])
    end
    @user = User.find(session[:user_id]) 
    @activity.user_id = @user.id
    respond_to do |format|
      if @activity.save
        format.js 
      end
    end
  end

  def update_organizations
    country = Country.find_by_id(params[:country_id], :include => :organizations, :order => 'organizations.title', :conditions => [ "organizations.pending = 0 OR organizations.added_by = ?", session[:user_id] ])
	render :update do |page|
        if country.blank?
            page.replace_html 'organization', :partial => 'organizations', :locals => {:id => params[:country_id] }, :object => nil
        else 
            page.replace_html 'organization', :partial => 'organizations', :locals => {:id => params[:country_id] }, :object => country.organizations
        end
        page << "initialize();" 
	end
  end


  def update_study_programs
	subject_area = SubjectArea.find_by_id(params[:subject_area_id], :include => :study_programs, :order => 'study_programs.title', :conditions => [ "study_programs.pending = 0 OR study_programs.added_by = ?", session[:user_id] ])
	render :update do |page|
        if subject_area.blank?
            page.replace_html 'study_program', :partial => 'study_programs', :locals => {:id => params[:subject_area_id] }, :object => nil
        else
            page.replace_html 'study_program', :partial => 'study_programs', :locals => {:id => params[:subject_area_id] }, :object => subject_area.study_programs
        end
        page << "initialize();" 
	end
  end

    def update_fields
	    render :update do |page|
            if (params[:activity_type] == "exchange_study")
                exchange_programs = ExchangeProgram.find(:all, :order => :title)
                page.replace_html 'exchange_program', :partial => 'exchange_programs', :locals => {}, :object => exchange_programs 
            elsif (params[:activity_type] == "internship")
                activity_areas = ActivityArea.find(:all, :order => :title)
                page.replace_html 'activity_area', :partial => 'activity_areas', :locals => {}, :object => activity_areas 
            end
            page << "initialize();" 
        end
    end

  end
