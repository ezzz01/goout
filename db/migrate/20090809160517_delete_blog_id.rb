class DeleteBlogId < ActiveRecord::Migration
  def self.up
    remove_column :posts, :blog_id
  end

  def self.down
  end
end
