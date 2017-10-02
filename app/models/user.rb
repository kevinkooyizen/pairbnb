require 'date'
require 'securerandom'

class User < ApplicationRecord
  attr_accessor :password_confirmation
  include Clearance::User
  validates :password_confirmation, presence: true, length: { minimum: 6, maximum: 20 }
  validates :password, presence: true, length: { minimum: 6, maximum: 20 }
  validates :first_name, presence: true
  validates :email, presence: true
  # validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]{2,}+\z/i
  # validates_uniqueness_of :email, case_sensitive: false
  validates_confirmation_of :password
  has_many :authentications, dependent: :destroy
  has_many :reservations
  mount_uploader :photo, PhotoUploader


	def self.create_with_auth_and_hash(authentication, auth_hash)
  	user = self.new(
  		first_name: auth_hash.info.first_name.scan(/\w+/)[0],
      last_name: auth_hash.info.last_name,
      full_name: auth_hash.info.name,
      provider: auth_hash.provider,
  		email: auth_hash.info.email,
      gender: auth_hash.extra.raw_info.gender,
      password: SecureRandom.base64(10),
    )
    if !auth_hash.extra.raw_info.location.nil?
      user.update(country: auth_hash.extra.raw_info.location.name)
    end
    if !auth_hash.extra.raw_info.birthday.nil?
      user.update(birthdate: Date.strptime(auth_hash.extra.raw_info.birthday, '%m/%d/%Y'))
    end
    user.save
		user.authentications << authentication
		return user
	end

	def fb_token
		x = self.authentications.find_by(provider: 'facebook')
		return x.token unless x.nil?
	end
end
