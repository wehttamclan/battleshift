class User < ApplicationRecord
  require 'securerandom'
  default_scope { order(id: :asc) }

  has_secure_password

  enum activated: {inactive: 0, active: 1}

  before_create do |user|
    self.api_key = SecureRandom.urlsafe_base64
  end

end
