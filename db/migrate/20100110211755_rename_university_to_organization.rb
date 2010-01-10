class RenameUniversityToOrganization < ActiveRecord::Migration
  def self.up
    drop_table :universities
    create_table :organizations, :options => 'default charset=utf8' do |t|
      t.string :type
      t.string :title
      t.string :city
      t.integer :country_id

      t.timestamps
    end

  end

  def self.down
  end
end
