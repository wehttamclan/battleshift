class User < ApplicationRecord
  default_scope { order(id: :asc) }
end
