class User < ApplicationRecord
  	include Clearance::User

  	has_many :authentications, dependent: :destroy

  	require 'securerandom'

  	def self.create_with_auth_and_hash(authentication, auth_hash)
	  	user = self.create!(
	  		name: auth_hash.info.name,
            provider: auth_hash.provider,
	  		email: auth_hash.info.email,
	  		password: SecureRandom.base64(10)
		)
		user.authentications << authentication
		return user
	end

	def fb_token
		x = self.authentications.find_by(provider: 'facebook')
		return x.token unless x.nil?
	end
end
