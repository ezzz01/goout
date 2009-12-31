class Cleanup < ActiveRecord::Migration
  def self.up
    drop_table :tags rescue puts("not found") 
    drop_table :taggings rescue puts("not found") 
    drop_table :globalize_countries rescue puts("not found") 
    drop_table :globalize_languages rescue puts("not found") 
    drop_table :globalize_translations rescue puts("not found") 
    drop_table :blogs rescue puts("not found") 
    drop_table :blog_posts rescue puts("not found") 
  end

  def self.down
  end
end
