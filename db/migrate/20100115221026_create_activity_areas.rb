class CreateActivityAreas < ActiveRecord::Migration
  def self.up
    create_table :activity_areas, :options => 'default charset=utf8' do |t|
      t.string :title
      t.text :description
      t.boolean :pending, :default => 1
	  t.integer :added_by

      t.timestamps
    end
  end

  def self.down
    drop_table :activity_areas
  end
end
