class ChangeVoteTypeFromBooleanToUnsignedInteger < ActiveRecord::Migration
  def self.up
    remove_column :votes, :vote
    add_column :votes, :vote, :integer 
  end

  def self.down
    remove_column :votes, :vote
    add_column :votes, :vote, :boolean
  end
end
