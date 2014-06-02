# == Schema Information
#
# Table name: api_tokens
#
#  id              :integer          not null, primary key
#  identifier      :string(255)      not null
#  password_digest :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class ApiToken < ActiveRecord::Base
  has_secure_password

  # The generated token, only available once
  attr_accessor :generated_token

  # The argument n specifies the length of the random length. The length of the result string is twice of n.
  RANDOM_LENGTH = 56

  def initialize(opts = {})
    super(opts)

    # Generate a long, RANDOM_LENGTH * 2 random password string
    generated_password = SecureRandom.hex(RANDOM_LENGTH)

    # Create a UUID v4 without dashes, which is guarunteed to be unique as per
    # See http://www.ietf.org/rfc/rfc4122.txt
    self.identifier = SecureRandom.uuid().gsub('-', '')
    self.generated_token = "#{identifier}:#{generated_password}".strip

    # We could use the password portion, but including the username gives this a little
    # extra salt and makes the verifier easier since we can pass in the whole string
    # to the has_secure_password bcrypt-based authenticate method.
    self.password = generated_token
  end

  ####################################################
  # Finders and its helper

  def self.api_key_from_token(token)
    to_return = (token and token.length >= 145) ? token.split(':').first : nil
    raise ActiveRecord::RecordNotFound if to_return.nil?
    to_return
  end

  # Find the token in the database by the identifier and compare the password hash
  # using the authenticate method that is supplied by has_secure_password.
  def self.find_by_token(token)
    api_token = ApiToken.find_by_identifier(api_key_from_token(token))
    if api_token and api_token.authenticate(token)
      return api_token
    else
      return nil
    end
  end # find_by_token

end # ApiToken
