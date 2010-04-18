class QuestionsController < ApplicationController
  load_and_authorize_resource

  def index
    @questions = Question.all.paginate(:per_page => 20)
  end

  def new
    @question = Question.new
    respond_to do |format|
      format.html
    end
  end

  def show

  end

  def create
    @question = Question.new(params[:question])
    @question.user = try(:current_user)
    respond_to do |format|
      if @question.duplicate? or @question.save 
        flash[:notice] = t(:question_created_successfully) 
        format.html { redirect_to root_url }
        format.js
      else
        format.html { render :action => "new" }
        format.js { render :nothing => true }
      end
    end
  end


  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    respond_to do |format|
      format.js
    end
  end


end
