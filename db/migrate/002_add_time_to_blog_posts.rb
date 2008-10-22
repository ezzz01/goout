class AddTimeToBlogPosts < ActiveRecord::Migration
  def self.up
    add_column :blog_posts, :time, :timestamp
  end

  def self.down
    remove_column :blog_posts, :time
  end
end
