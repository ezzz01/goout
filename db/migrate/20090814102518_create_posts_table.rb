class CreatePostsTable < ActiveRecord::Migration
  def self.up
     create_table :posts, :options => 'default charset=utf8' do |t|
      t.column :blog_id, :integer
      t.column :title, :string
      t.column :body, :text
      t.timestamps
    end
  end

  def self.down
  end
end
