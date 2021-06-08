require 'bitly'

class Member < ApplicationRecord

  # Define self-referential relationships for friending functionalities
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :member

  # Store member website headings
  has_many :site_contents

  attr_accessible :first_name, :last_name, :username, :password, :url, :short_url
  attr_accessor :password
  before_save :prepare_username, :prepare_password, :prepare_short_url

  validates_presence_of :username
  validates_uniqueness_of :username
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password

  def self.authenticate(first_name, last_name, url, pass)
    username = "#{first_name}_#{last_name}_#{url}"
    member = find_by_username(username)
    return member if member && member.matching_password?(pass)
  end
  
  def matching_password?(pass)
    self.password_hash == encrypt_password(pass)
  end
  
  private

  BITLY_ACCESS_TOKEN = '054d6f655c159676369320125e6c8cb4293082f4'

  # Username would be the combination of first/last name of the member and the website URL
  def prepare_username
    self.username = "#{first_name}_#{last_name}_#{url}"
  end
  
  # Password would be hashed before storage
  def prepare_password
    unless password.blank?
      self.password_salt = Digest::SHA1.hexdigest([Time.now, rand].join)
      self.password_hash = encrypt_password(password)
    end
  end

  def prepare_short_url
    self.short_url = generate_short_url(url)
  end
  
  def encrypt_password(pass)
    Digest::SHA1.hexdigest([pass, password_salt].join)
  end

  # Using Bitly gem for generating shorten URL with temporarly access token retrieved from Bitly official website
  def generate_short_url(url)
    bitly_client = Bitly::API::Client.new(token: BITLY_ACCESS_TOKEN)
    bitlink = bitly_client.shorten(long_url: url)
    bitlink.link
  end
end
