class AddVotesTable < ActiveRecord::Migration
  def self.up
    create_table :votes, :options => 'default charset=utf8' do |t|
      t.boolean :vote, :default => false
      t.integer :voteable_id, :default => 0, :null => false
      t.integer :user_id, :default => 0, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :votes 
  end
end
