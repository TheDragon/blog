require 'digest/sha1'
class User < ActiveRecord::Base
  validates_presence_of :username, :password, :email
  validates_uniqueness_of :username, :email
  validates_length_of :username, :within => 4..20
  validates_length_of :password, :within => 6..15
#  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-s0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email format"
  
  before_create :pass_encrypt

  attr_protected :id
  attr_accessor :password

  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  def self.authenticate(username, pass)
    @user = User.find_by_username(username)
    if @user && @user.encrypt(pass)
      return @user
    end
  end

  protected
  def pass_encrypt
    self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{self.username}--") if new_record?
    self.pass_hash = encrypt(password)
  end

end
