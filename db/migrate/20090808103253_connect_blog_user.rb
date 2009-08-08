class ConnectBlogUser < ActiveRecord::Migration
  def self.up
    add_column :blogs, "user_id", :integer
  end

  def self.down
  end
end
