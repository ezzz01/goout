class StudiesController < ApplicationController
  include ApplicationHelper
#  before_filter :protect, :only => ["new", "create", "delete", "update"]

  def new 
    @universities = University.find(:all)
    @study = Study.new
    respond_to do |format|
      format.js 
    end
  end

  def edit

  end

  def create
    @study = Study.new(params[:study])
    @user = User.find(session[:user_id]) 
    @study.user_id = @user.id
    respond_to do |format|
      if @study.save
        format.js 
      end
    end
  end

  def update_universities
	country = Country.find(params[:country_id])
	if country
		universities = country.universities
	end

	render :update do |page|
		page.replace_html 'universities', :partial => 'universities', :locals => {:id => params[:country_id] }, :object => universities
        page << "initialize();" 
	end

  end

  end
