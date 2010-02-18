class AddWikiReferences < ActiveRecord::Migration
  def self.up
  create_table :wiki_references, :options => 'default charset=utf8'  do |t|
      t.column :created_at, :datetime, :null => false
      t.column :updated_at, :datetime, :null => false
      t.column :concept_id, :integer, :default => 0, :null => false
      t.column :referenced_name, :string, :limit => 60, :default => "", :null => false
      t.column :link_type, :string, :limit => 1, :default => "", :null => false
    end

  end

  def self.down
    drop_table :wiki_references
  end
end
