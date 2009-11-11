class StudiesController < ApplicationController
  include ApplicationHelper
  helper :profile
#  before_filter :protect, :only => ["new", "create", "delete", "update"]

  def index 
    @studies = Study.find(:all)
  end

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

  end
