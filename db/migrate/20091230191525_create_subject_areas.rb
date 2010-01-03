class CreateSubjectAreas < ActiveRecord::Migration
  def self.up
    create_table :subject_areas, :options => 'default charset=utf8' do |t|
      t.string :title
      t.timestamps
    end
  end

  def self.down
    drop_table :subject_areas
  end
end
