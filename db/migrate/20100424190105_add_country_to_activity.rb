class AddCountryToActivity < ActiveRecord::Migration
  def self.up
    add_column :activities, :country_id, :integer
  end

  def self.down
    remove_column :activities, :country_id
  end
end
