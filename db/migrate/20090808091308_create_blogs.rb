class CreateBlogs < ActiveRecord::Migration
  def self.up
    create_table :blogs, :options => 'default charset=utf8' do |t|
      t.column :title, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :blogs
  end
end
