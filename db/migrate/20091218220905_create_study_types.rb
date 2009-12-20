class CreateStudyTypes < ActiveRecord::Migration
  def self.up
    create_table :study_types , :options => 'default charset=utf8' do |t|
      t.string :title
      t.timestamps
    end
  end

  def self.down
    drop_table :study_types
  end
end
