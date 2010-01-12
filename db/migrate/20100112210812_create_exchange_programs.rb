class CreateExchangePrograms < ActiveRecord::Migration
  def self.up
    create_table :exchange_programs, :options => 'default charset=utf8' do |t|
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :exchange_programs
  end
end
