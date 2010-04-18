class AddQuestion < ActiveRecord::Migration
  def self.up
    create_table :questions, :options => 'default charset=utf8' do |t|
      t.text :body
      t.integer :user_id
      t.string :cached_tag_list
      t.integer :vote_for
      t.integer :vote_agains
      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
