class User < ActiveRecord::Base
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
  
  def self.logout!(session)
    session[:user_id] = nil 
  end

  def clear_password!
    self.password = nil
  end

end
