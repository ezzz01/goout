class MergeCountriesUnisIntoConcept < ActiveRecord::Migration
  def self.up
    add_column :concepts, :type, :string
	add_column :concepts, :pending, :boolean, :default => 1
	add_column :concepts, :added_by, :integer
    add_column :concepts, :subject_area_id, :integer 
    drop_table "activity_areas"
    drop_table "countries"
    drop_table "exchange_programs"
    drop_table "organizations"
    drop_table "study_programs"
  end

  def self.down
	remove_column :concepts, :pending
	remove_column :concepts, :added_by
    remove_column :concepts, :subject_area_id
  end
end
