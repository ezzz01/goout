class AddStudyProgramToStudy < ActiveRecord::Migration
  def self.up
	remove_column :studies, :subject_area_id
	add_column :studies, :study_program_id, :integer

  end

  def self.down
    remove_column :studies, :study_program_id
	add_column :studies, :subject_area_id, :integer
  end
end
