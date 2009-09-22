class CreateUniversities < ActiveRecord::Migration
  def self.up
    create_table :universities, :options => 'default charset=utf8' do |t|
      t.string :title
      t.string :city
      t.integer :country_id

      t.timestamps
    end
  end

  def self.down
    drop_table :universities
  end
end
