require 'digest/sha1'

class User < ActiveRecord::Base
  has_many :posts

  validates_presence_of :username, :password, :email
  validates_uniqueness_of :username, :email
  validates_length_of :username, :within => 4..20
  validates_length_of :password, :within => 6..15
#  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-s0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email format"
  
  before_create :pass_encrypt

  # This prevents the 'id' attribute from being modified by a form POST.
  attr_protected :id

  # This creates a virtual attribute to store the unencrypted password.
  attr_accessor :password

  # This method is an instance method (ex. @user.encrypt), which is a wrapper
  # for the class method (User.encrypt).  The reasoning for this is to have the
  # encryption scheme in a single location.  The wrapper is needed because we
  # need to get the User's salt before we can correctly validate them.
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  # This is the class method (User.encrypt) which holds the encryption scheme.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # This class method returns a User or nil.
  def self.authenticate(username, pass)
    @user = User.find_by_username(username)
    if @user && @user.encrypt(pass)
      return @user
    end
  end

  protected

  # before_create filter which will generate a salt value for a new User.
  def pass_encrypt
    self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{self.username}--") if new_record?
    self.pass_hash = encrypt(password)
  end
end
