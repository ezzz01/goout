require 'digest/sha1'
class User < ActiveRecord::Base
  acts_as_authentic

  has_one :spec
  has_one :avatar, :dependent => :destroy
  has_many :posts, :order => "created_at DESC"
  has_many :comments, :order => "created_at DESC"
  has_many :activities
  has_many :organizations, :through => :activities
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  has_many :userroles, :class_name => "UserRole"
  has_many :roles, :through => :userroles

  attr_accessor :remember_me
  attr_accessor :current_password
  attr_accessor :admin
  attr_accessor :updating_user

  USERNAME_MIN_LENGTH = 4
  USERNAME_MAX_LENGTH = 20
  PASSWORD_MIN_LENGTH = 4
  PASSWORD_MAX_LENGTH = 20
  EMAIL_MAX_LENGTH = 50
  BLOG_MAX_LENGTH = 100
  USERNAME_SIZE = 30
  PASSWORD_SIZE = 30
  EMAIL_SIZE = 30
  BLOG_URL_SIZE = 30
  USERNAME_RANGE = USERNAME_MIN_LENGTH..USERNAME_MAX_LENGTH
  PASSWORD_RANGE = PASSWORD_MIN_LENGTH..PASSWORD_MAX_LENGTH

  validates_uniqueness_of :username, :email
  validates_confirmation_of :password, :unless => :updating_user
  validates_length_of     :username, :within => USERNAME_RANGE
  validates_length_of     :password, :within => PASSWORD_RANGE, :unless => :updating_user
  validates_length_of     :email,   :maximum => EMAIL_MAX_LENGTH 
  validates_length_of     :blog_url, :maximum => BLOG_MAX_LENGTH, :allow_nil => true 
  validates_format_of :email,
                      :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
                      :message => I18n.t(:must_be_valid) 
  validates_format_of :username,
                      :with => /^[A-Z0-9_-]*$/i,
                      :message => I18n.t(:username_error)


  def validate
    if username.include?(" ")
      errors.add(:username, I18n.t(:no_spaces))
    end

#    if blog_url.include?(" ")
 #     errors.add(:blog_url, I18n.t(:no_spaces))
  #  end
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
    errors.add(:current_password, I18n.t(:not_correct))
  end

  private
  def unique_identifier
    Digest::SHA1.hexdigest("{#username}:{#password}")
  end
end
