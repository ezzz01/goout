class CreateConcepts < ActiveRecord::Migration
  def self.up
    create_table :concepts, :options => 'default charset=utf8' do |t|
      t.string :title
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :concepts
  end
end
