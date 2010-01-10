class RemoveStudyTypes < ActiveRecord::Migration
  def self.up
    drop_table :study_types
  end

  def self.down
  end
end
