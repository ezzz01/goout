class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  validates_presence_of :body
  validates_length_of :title, :maximum => 100
  validates_length_of :body, :maximum => DB_TEXT_MAX_LENGTH
end
