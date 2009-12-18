class AddStudyType < ActiveRecord::Migration
  def self.up
    add_column :studies, :study_type_id, :integer
  end

  def self.down
    remove_column :studies, :study_type_id
  end
end
