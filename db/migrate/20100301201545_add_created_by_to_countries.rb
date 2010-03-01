class AddCreatedByToCountries < ActiveRecord::Migration
  def self.up
	add_column :countries, :pending, :boolean, :default => 1
	add_column :countries, :added_by, :integer
  end

  def self.down
	remove_column :countries, :pending
	remove_column :countries, :added_by
  end
end
