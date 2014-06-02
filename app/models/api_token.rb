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
    generated_password = SecureRandom.hex(RANDOM_LENGTH)
    # Create a UUID v4 without dashes, which is guarunteed to be unique as per
    # See http://www.ietf.org/rfc/rfc4122.txt
    self.identifier = SecureRandom.uuid().gsub('-', '')
    self.generated_token = "#{identifier}:#{generated_password}".strip
    self.password = generated_password
  end

end
