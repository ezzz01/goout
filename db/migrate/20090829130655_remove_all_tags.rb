class RemoveAllTags < ActiveRecord::Migration
  def self.up
    drop_table :tags
    drop_table :post_tags
  end

  def self.down
  end
end
