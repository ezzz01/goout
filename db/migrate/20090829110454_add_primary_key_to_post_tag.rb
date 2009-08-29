class AddPrimaryKeyToPostTag < ActiveRecord::Migration
 def self.up
    create_table :post_tags do |t|
      t.references :post
      t.references :tag
      t.timestamps
    end
  end

  def self.down
    drop_table :post_tags
  end
end
