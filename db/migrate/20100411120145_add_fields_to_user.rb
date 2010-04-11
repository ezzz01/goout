class AddFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :gender, :string
    add_column :users, :birthdate, :date
    add_column :users, :name, :string
    add_column :users, :surname, :string
    add_column :users, :current_country, :integer
  end

  def self.down
    remove_column :users, :gender 
    remove_column :users, :birthdate
    remove_column :users, :name
    remove_column :users, :suname
    remove_column :users, :current_country
  end
end
