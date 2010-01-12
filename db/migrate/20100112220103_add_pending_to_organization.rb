class AddPendingToOrganization < ActiveRecord::Migration
  def self.up
	add_column :organizations, :pending, :boolean, :default => 1
	add_column :organizations, :added_by, :integer
  end

  def self.down
	remove_column :organizations, :pending
	remove_column :organizations, :added_by
  end
end
