class CreateRevisions < ActiveRecord::Migration
  def self.up
    create_table :revisions, :options => 'default charset=utf8' do |t|
      t.text :content
      t.integer :author_id
      t.integer :concept_id

      t.timestamps
    end
  end

  def self.down
    drop_table :revisions
  end
end
