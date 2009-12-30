class AddSubjectAreaToStudy < ActiveRecord::Migration
  def self.up
    add_column :studies, :subject_area_id, :integer
  end

  def self.down
    remove_column :studies, :subject_area_id
  end
end
