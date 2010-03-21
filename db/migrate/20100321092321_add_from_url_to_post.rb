class AddFromUrlToPost < ActiveRecord::Migration
  def self.up
    add_column :posts, :from_url, :string
  end

  def self.down
    remove_column :posts, :from_url
  end
end
