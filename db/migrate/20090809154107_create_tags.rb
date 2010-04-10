class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags , :options => 'default charset=utf8' do |t|
      t.string :tag

      t.timestamps
    end
  end

  def self.down
    drop_table :tags
  end
end
