class DeleteVoteCountsFromAnswers < ActiveRecord::Migration
  def self.up
    remove_column :answers, :vote_for
    remove_column :answers, :vote_against
  end

  def self.down
    add_column :answers, :vote_for, :integer
    add_column :answers, :vote_against, :integer
  end
end
