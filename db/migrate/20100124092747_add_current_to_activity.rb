class AddCurrentToActivity < ActiveRecord::Migration
  def self.up
    add_column :activities, :current, :boolean, :default => 0
  end

  def self.down
  end
end
