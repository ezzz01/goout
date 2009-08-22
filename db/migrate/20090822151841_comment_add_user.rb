class CommentAddUser < ActiveRecord::Migration
  def self.up
     add_column (:comments, :user_id, :int)
  end

  def self.down
  end
end
