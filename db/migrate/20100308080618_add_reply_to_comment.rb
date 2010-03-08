class AddReplyToComment < ActiveRecord::Migration
  def self.up
    add_column :comments, :in_reply_to_id, :integer
  end

  def self.down
    remove_column :comments, :in_reply_to_id
  end
end
