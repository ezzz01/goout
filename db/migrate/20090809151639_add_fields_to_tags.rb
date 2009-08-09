class AddFieldsToTags < ActiveRecord::Migration
  def self.up
    add_column :tags, :tag, :string
  end

  def self.down
    remove_column :tag
  end
end
