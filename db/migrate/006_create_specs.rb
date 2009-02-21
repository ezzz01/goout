class CreateSpecs < ActiveRecord::Migration
  def self.up
    create_table :specs do |t|
      t.column :user_id, :integer, :null => false
      t.column :first_name, :string, :default => ""
      t.column :last_name, :string, :default => ""
      t.column :birthdate, :date
      t.timestamps
    end
  end

  def self.down
    drop_table :specs
  end
end
