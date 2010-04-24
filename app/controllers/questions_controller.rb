class QuestionsController < ApplicationController
  load_and_authorize_resource

  def index
    @title = t(:all_questions)
    @questions = Question.all.paginate(:per_page => 20)
  end

  def new
    @question = Question.new
    respond_to do |format|
      format.html
    end
  end

  def show
    @title = truncate(@question.body, :length => 100, :ommision => "...")  
  end

  def create
    @title = t(:new_question)
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
      format.html { redirect_to questions_path }
    end
  end


end
