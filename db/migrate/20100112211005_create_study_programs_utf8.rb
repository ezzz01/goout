class CreateStudyProgramsUtf8 < ActiveRecord::Migration
  def self.up
    drop_table :study_programs

    create_table :study_programs , :options => 'default charset=utf8' do |t|
      t.string :title
      t.integer :subject_area_id

      t.timestamps
    end

  end

  def self.down
  end
end
