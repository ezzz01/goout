class AddCountryIdToConcept < ActiveRecord::Migration
  def self.up
    add_column :concepts, :country_id, :integer
  end

  def self.down
	remove_column :concepts, :country_id
  end
end
