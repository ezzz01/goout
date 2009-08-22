class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :order => "created_at", :dependent => :destroy

  validates_presence_of :body
  validates_length_of :title, :maximum => 100
  validates_length_of :body, :maximum => DB_TEXT_MAX_LENGTH
  validates_uniqueness_of :body, :scope => :title

  def duplicate?
    post = Post.find_by_user_id_and_title_and_body(user_id, title, body)
    self.id = post.id unless post.nil?
    not post.nil?
  end
end
