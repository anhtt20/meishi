class Role < ApplicationRecord
  has_many :map_roles, primary_key: 'role_id', foreign_key: 'role_id'
  has_many :users, :through => :map_roles
end
