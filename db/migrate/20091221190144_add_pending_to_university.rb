class AddPendingToUniversity < ActiveRecord::Migration
  def self.up
  	add_column :universities, :pending, :boolean, :default => 1
	add_column :universities, :added_by, :integer
  end

  def self.down
  	remove_column :universities, :pending
	remove_column :universities, :added_by
  end
end
