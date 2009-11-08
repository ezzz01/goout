class CreateStudies < ActiveRecord::Migration
  def self.up
    create_table :studies , :options => 'default charset=utf8' do |t|
      t.integer :user_id
      t.integer :university_id
      t.date :from
      t.date :to
      t.timestamps
    end
  end

  def self.down
    drop_table :studies
  end
end
