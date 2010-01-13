class AddPendingToExchangePrograms < ActiveRecord::Migration
  def self.up
    add_column :exchange_programs, :pending, :boolean, :default => 1
	add_column :exchange_programs, :added_by, :integer
  end

  def self.down
	remove_column :exchange_programs, :pending
	remove_column :exchange_programs, :added_by
  end
end
