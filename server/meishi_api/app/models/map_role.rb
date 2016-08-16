class MapRole < ApplicationRecord
  belongs_to :user, primary_key: 'user_id', foreign_key: 'user_id'
  belongs_to :role, primary_key: 'role_id', foreign_key: 'role_id'
end
