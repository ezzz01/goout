class ConnectBlogWithUser < ActiveRecord::Migration
  def self.up
    add_column :users, "blog_id", :integer
  end

  def self.down
  end
end
