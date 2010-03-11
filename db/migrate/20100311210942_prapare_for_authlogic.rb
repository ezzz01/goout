class PrapareForAuthlogic < ActiveRecord::Migration
  def self.up
   rename_column :users, :authorization_token, :persistence_token
   rename_column :users, :password, :crypted_password
   add_column :users, :password_salt, :string
    add_column :users, :last_login_ip, :string
    add_column :users, :current_login_ip, :string
  end

  def self.down
   rename_column :users, :persistence_token, :authorization_token
   rename_column :users, :crypted_password, :password
   remove_column :users, :password_salt
    remove_column :users, :last_login_ip 
    remove_column :users, :current_login_ip
  end

end
