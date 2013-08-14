require 'digest/sha2'

class User < ActiveRecord::Base
  attr_accessible :email, :firstname, :lastname, :password, :password_confirmation

  validates :firstname, :presence => true
  validates :lastname, :presence => true
  validates :email, :presence => true, :uniqueness => true
  validates :password, :confirmation => true
  validate  :password_must_be_present
  validates_format_of :password, :with => /^\S*(?=\S{8,})(?=\S*[a-z])(?=\S*[A-Z])(?=\S*[\d])\S*$/i, :message => 'must be at least 8 characters and contain one number, one uppercase and one lowercase letter'
  validates_format_of :email, :with => /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/, :message =>  'address is invalid'

  attr_accessor :password_confirmation
  attr_reader   :password

  def User.authenticate(email, password) 
  	puts 'I am here email: ' + password
  	if user = find_by_email(email)
  		if user.hashed_password == encrypt_password(password, user.salt) 
  			user
  		end 
  	end
  end

  def User.encrypt_password(password, salt) 
		Digest::SHA2.hexdigest(password + "wibble" + salt)
  end

  def password=(password)
  	@password = password
  	if password.present?
  		generate_salt
  		self.hashed_password = self.class.encrypt_password(password, salt)
  	end 
  end

  private

	def password_must_be_present
		errors.add(:password, "Missing password") unless hashed_password.present?
	end

  def password_strength

    errors.add(:password, "Missing password") unless hashed_password.present?
  end

	def generate_salt
		self.salt = self.object_id.to_s + rand.to_s
	end

end
