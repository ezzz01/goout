class AddSpecToConcept < ActiveRecord::Migration
  def self.up
    add_column :concepts, :goout_intern, :boolean, :default => 0
  end

  def self.down
    remove_column :concepts, :goout_intern
  end
end
