class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  validates_presence_of :body, :question
  validates_length_of :body, :maximum => DB_TEXT_MAX_LENGTH
  validates_uniqueness_of :body, :scope => [:question_id, :user_id] 

  def duplicate?
    c = Answer.find_by_question_id_and_body(question, body)
    self.id = c.id unless c.nil?
    not c.nil?
  end
end
