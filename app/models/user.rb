class User < ApplicationRecord
  default_scope { order(id: :asc) }

  has_secure_password

  enum activated: {inactive: 0, active: 1}
end
