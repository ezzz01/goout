class AnswersController < ApplicationController
  load_and_authorize_resource
  before_filter :load_question, :only => ["index", "new", "create"]

 def index
    redirect_to question_path(@question)
 end

 def new
    respond_to do |format|
      format.js 
    end
 end

 def create
    @answer = @question.answers.build(params[:answer])
    @answer.user_id = (current_user.nil?)? nil : current_user.id 

    respond_to do |format|
      if @answer.duplicate? or @answer.save
        format.html { redirect_to root_url }
        format.js 
      else
        format.html { render :action => "new" }
        format.js { render :nothing => true}
      end
    end
 end

 def destroy

 end

 def load_question
    @question = Question.find(params[:question_id])
  end

  def vote_for
    @answer = Answer.find(params[:answer_id])
    @answer.vote_for = 0 if @answer.try(:vote_for).nil?
    @question = @answer.question
    votes_for = @answer.vote_for + 1
      if @answer.update_attribute(:vote_for, votes_for)
        render :update do |page|
          page.replace_html "votes_for_#{@answer.id}", votes_for 
          page.replace_html "answers_for_question_#{@question.id}",
                :partial => "answers/answer",
                :collection => @question.answers.find(:all, :order => "(vote_for - vote_against) DESC, created_at DESC", :limit => 3)

        end
      end
  end

  def vote_against
    @answer = Answer.find(params[:answer_id])
    @answer.vote_against = 0 if @answer.try(:vote_against).nil?
    @question = @answer.question
    vote_against = @answer.vote_against + 1
      if @answer.update_attribute(:vote_against, vote_against)
        render :update do |page|
          page.replace_html "vote_against_#{@answer.id}", vote_against
          page.replace_html "answers_for_question_#{@question.id}",
                :partial => "answers/answer",
                :collection => @question.answers.find(:all, :order => "vote_for DESC, created_at DESC", :limit => 3)
        end
      end
  end

end
