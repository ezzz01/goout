class AddPendingToStudyProgram2 < ActiveRecord::Migration
  def self.up
    add_column :study_programs, :pending, :boolean, :default => 1
	add_column :study_programs, :added_by, :integer
  end

  def self.down
	remove_column :study_programs, :pending
	remove_column :study_programs, :added_by
  end
end
