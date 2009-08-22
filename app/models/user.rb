require 'digest/sha1'
class User < ActiveRecord::Base
  has_one :spec
  has_many :posts, :order => "created_at DESC"
  has_many :comments, :order => "created_at DESC", :dependent => :destroy

  attr_accessor :remember_me
  attr_accessor :current_password

  USERNAME_MIN_LENGTH = 4
  USERNAME_MAX_LENGTH = 20
  PASSWORD_MIN_LENGTH = 4
  PASSWORD_MAX_LENGTH = 20
  EMAIL_MAX_LENGTH = 50
  USERNAME_SIZE = 30
  PASSWORD_SIZE = 30
  EMAIL_SIZE = 30
  USERNAME_RANGE = USERNAME_MIN_LENGTH..USERNAME_MAX_LENGTH
  PASSWORD_RANGE = PASSWORD_MIN_LENGTH..PASSWORD_MAX_LENGTH

  validates_uniqueness_of :username, :email
  validates_confirmation_of :password
  validates_length_of     :username, :within => USERNAME_RANGE
  validates_length_of     :password, :within => PASSWORD_RANGE
  validates_length_of     :email,   :maximum => EMAIL_MAX_LENGTH 
  validates_format_of :username,
                      :with => /^[A-Z0-9_-]*$/i,
                      :message => "must contain only letters, numbers, underscores and dashes"


  def validate
    errors.add(:email, "must be valid.") unless email.include? ("@")
    if username.include?(" ")
      errors.add(:username, "cannot include spaces.")
    end
  end
 
  def login!(session)
    session[:user_id] = self.id
  end
  
  def self.logout!(session, cookies)
    session[:user_id] = nil 
    cookies.delete(:authorization_token)
  end

  def remember!(cookies)
    cookie_expiration = 4.months.from_now
    cookies[:remember_me] = { :value => "1",
                              :expires => cookie_expiration }
    self.authorization_token = unique_identifier 
    save!
    cookies[:authorization_token] = {
      :value => self.authorization_token,
      :expires => cookie_expiration }
  end

  def forget!(cookies)
     cookies.delete(:remember_me)
     cookies.delete(:authorization_token)
  end

  def remember_me?
    remember_me == "1"
  end

  def clear_password!
    self.password = nil
    self.password_confirmation = nil
    self.current_password = nil
  end

  def correct_password?(params)
    current_password = params[:user][:current_password]
    password == current_password
  end

  def password_errors(params)
    self.password = params[:user][:password]
    self.password_confirmation = params[:user][:password_confirmation]
    valid?
    errors.add(:current_password, "is incorrect")
  end

  private
  def unique_identifier
    Digest::SHA1.hexdigest("{#username}:{#password}")
  end
end
