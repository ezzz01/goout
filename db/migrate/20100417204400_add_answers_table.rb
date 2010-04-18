class AddAnswersTable < ActiveRecord::Migration
  def self.up
    create_table :answers, :options => 'default charset=utf8' do |t|
      t.text :body
      t.integer :user_id
      t.integer :question_id
      t.integer :vote_for
      t.integer :vote_against
      t.timestamps
    end
  end

  def self.down
    drop_table :answers
  end
end
