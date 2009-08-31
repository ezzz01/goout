class AddBlogurlToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :blog_url, :string
    add_column :users, :blog_type, :string
  end

  def self.down
    remove_column :users, :blog_url
    remove_column :users, :blog_type
  end
end
