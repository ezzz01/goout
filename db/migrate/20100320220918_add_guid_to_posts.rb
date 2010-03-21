class AddGuidToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :guid, :string
    add_column :posts, :url, :string
  end

  def self.down
    remove_column :posts, :guid 
    remove_column :posts, :url
  end
end
