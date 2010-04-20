class AddVoteableTypeToVotes < ActiveRecord::Migration
  def self.up
    add_column :votes, :voteable_type, :string
  end

  def self.down
    remove_column :votes, :voteable_type
  end
end
