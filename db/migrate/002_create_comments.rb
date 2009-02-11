class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments, :options => 'default charset=utf8' do |t|
      t.references :blog_post
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
